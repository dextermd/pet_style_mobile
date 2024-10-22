import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
import 'package:pet_style_mobile/src/data/model/appointment/hw_day_of_week_appointmen.dart';
import 'package:pet_style_mobile/src/data/model/appointment/time_slot_appointment.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _appointmentRepository;
  final UserRepository _userRepository;

  AppointmentBloc(this._appointmentRepository, this._userRepository)
      : super(AppointmentInitial()) {
    on<GetAvailableDaysOfWeekEvent>(_onGetAvailableDaysOfWeek);
    on<GetAvailableTimeSlotsEvent>(_onGetAvailableTimeSlots);
    on<GetPetsProfleEvent>(_onGetPetsProfile);
    on<InitDatesEvent>(_onInitDates);
    on<CheckPhoneNumberEvent>(_onCheckPhoneNumber);
    on<CreateAppointmentEvent>(_onCreateAppointment);
    on<AddPhoneNumberExistStateEvent>(_onAddPhoneNumberExistState);
    on<CheckIfExistingAppointmentEvent>(_onCheckIfExistingAppointment);
  }

  void _onGetPetsProfile(
      GetPetsProfleEvent event, Emitter<AppointmentState> emit) async {
    emit(PetsProfileLoading());
    try {
      final User? userData = await _userRepository.getUserData();
      if (userData?.pets == null) {
        emit(const PetsProfileError('У вас нет питомцев'));
        return;
      }
      if (event.isHomeAppointment) {
        if (userData?.pets?.where((element) => element.type == 'Dog').isEmpty ??
            true) {
          emit(const PetsProfileError(
              'У вас нет собак, на домашний уход можно записаться только с собакой'));
          return;
        } else {
          AppointmentState.pets = userData?.pets ?? [];
        }
      } else {
        AppointmentState.pets = userData?.pets ?? [];
      }

      emit(PetsProfileLoaded());
    } catch (e) {
      emit(PetsProfileError(e.toString()));
      AppointmentState.pets = [];
    }
  }

  void _onGetAvailableDaysOfWeek(
      GetAvailableDaysOfWeekEvent event, Emitter<AppointmentState> emit) async {
    emit(AvailableDaysOfWeekLoading());
    try {
      final HwDayOfWeekAppointmen hwDayOfWeekAppointmen =
          await _appointmentRepository.getAvailableDaysOfWeek(event.groomerId);
      add(InitDatesEvent(hwDayOfWeekAppointmen));
    } catch (e) {
      emit(AvailableDaysOfWeekError(e.toString()));
      AppointmentState.activeDates = [];
      AppointmentState.timeSlotAppointment =
          const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);
      AppointmentState.pets = [];
    }
  }

  void _onGetAvailableTimeSlots(
      GetAvailableTimeSlotsEvent event, Emitter<AppointmentState> emit) async {
    emit(SlotsLoading());
    try {
      final TimeSlotAppointment timeSlotAppointment =
          await _appointmentRepository.getAvailableTimeSlots(
        event.date,
        event.groomerId,
      );
      logDebug('timeSlotAppointment: $timeSlotAppointment');
      if (timeSlotAppointment.availableTimeSlot!.isEmpty) {
        emit(SlotsEmpty());
      } else {
        emit(SlotsLoaded());
      }
      AppointmentState.timeSlotAppointment = timeSlotAppointment;
    } catch (e) {
      emit(AvailableSlotsError(e.toString()));
      AppointmentState.timeSlotAppointment =
          const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);
      AppointmentState.pets = [];
    }
  }

  void _onInitDates(InitDatesEvent event, Emitter<AppointmentState> emit) {
    final List<DateTime> activeDates = [];
    DateTime startDate = DateTime.now();
    DateTime endDate = startDate.add(const Duration(days: 14));

    for (DateTime date = startDate;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 1))) {
      if (event.hwDayOfWeekAppointmen.homeWorkDayOfWeek!
          .contains(date.weekday)) {
        activeDates.add(date);
      }
      logDebug('activeDates: $activeDates');
    }

    if (activeDates.isEmpty) {
      emit(const AvailableDaysOfWeekError('График работы не найден'));
      return;
    }
    AppointmentState.activeDates = activeDates;
    AppointmentState.timeSlotAppointment =
        const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);

    emit(AppointmentInitial());
  }

  FutureOr<void> _onCheckPhoneNumber(
      CheckPhoneNumberEvent event, Emitter<AppointmentState> emit) async {
    try {
      final bool isPhoneNumberExist =
          await _userRepository.isPhoneNumberExist();
      if (isPhoneNumberExist) {
        emit(PhoneNumberExist());
      } else {
        emit(PhoneNumberEmpty());
      }
      emit(AppointmentInitial());
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onCreateAppointment(
      CreateAppointmentEvent event, Emitter<AppointmentState> emit) async {
    try {
      await _appointmentRepository.createAppointment(event.appointment);
      logDebug('Appointment created');
      emit(CreateAppointmentSuccess());
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onAddPhoneNumberExistState(
    AddPhoneNumberExistStateEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(PhoneNumberExist());
  }

  FutureOr<void> _onCheckIfExistingAppointment(CheckIfExistingAppointmentEvent event, Emitter<AppointmentState> emit) async {
    try {
      final bool isExist = await _appointmentRepository.isAppointmentExistByDateAndPetId(event.date, event.petId);
      if (isExist) {
        emit(AppointmentExist());
      } else {
        emit(AppointmentNotExist());
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
