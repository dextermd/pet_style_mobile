import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/src/data/model/appointment/hw_day_of_week_appointmen.dart';
import 'package:pet_style_mobile/src/data/model/appointment/time_slot_appointment.dart';
import 'package:pet_style_mobile/src/data/model/pet/pet.dart';
import 'package:pet_style_mobile/src/data/model/user/user.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';
import 'package:pet_style_mobile/src/domain/repository/user_repository.dart';


part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository appointmentRepository;
  final UserRepository userRepository;

  AppointmentBloc(this.appointmentRepository, this.userRepository)
      : super(AppointmentInitial()) {
    on<AppointmentGetAvailableDaysOfWeekEvent>(_onGetAvailableDaysOfWeek);
    on<AppointmentGetAvailableTimeSlotsEvent>(_onGetAvailableTimeSlots);
    on<AppointmentGetPetsProfleEvent>(_onGetPetsProfile);
    on<AppointmentInitDatesEvent>(_onInitDates);
  }

  void _onGetPetsProfile(AppointmentGetPetsProfleEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentPetsProfileLoading());
    try {
      final User? userData = await userRepository.getUserData();
      if (userData?.pets == null) {
        emit(const AppointmentPetsProfileError('У вас нет питомцев'));
        return;
      }
      if (event.isHomeAppointment) {
        if (userData?.pets?.where((element) => element.type == 'Dog').isEmpty ??
            true) {
          emit(const AppointmentPetsProfileError(
              'У вас нет собак, на домашний уход можно записаться только с собакой'));
          return;
        } else {
          AppointmentState.pets = userData?.pets ?? [];
        }
      } else {
        AppointmentState.pets = userData?.pets ?? [];
      }

      emit(AppointmentInitial());
    } catch (e) {
      emit(AppointmentPetsProfileError(e.toString()));
      AppointmentState.pets = [];
    }
  }

  void _onGetAvailableDaysOfWeek(AppointmentGetAvailableDaysOfWeekEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentAvailableDaysOfWeekLoading());
    try {
      final HwDayOfWeekAppointmen hwDayOfWeekAppointmen =
          await appointmentRepository.getAvailableDaysOfWeek(event.groomerId);
      add(AppointmentInitDatesEvent(hwDayOfWeekAppointmen));
    } catch (e) {
      emit(AppointmentAvailableDaysOfWeekError(e.toString()));
      AppointmentState.activeDates = [];
      AppointmentState.timeSlotAppointment =
          const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);
      AppointmentState.pets = [];
    }
  }

  void _onGetAvailableTimeSlots(AppointmentGetAvailableTimeSlotsEvent event,
      Emitter<AppointmentState> emit) async {
    emit(AppointmentAvailableSlotsLoading());
    try {
      final TimeSlotAppointment timeSlotAppointment =
          await appointmentRepository.getAvailableTimeSlots(
              event.date, event.groomerId);
      AppointmentState.timeSlotAppointment = timeSlotAppointment;
      logDebug('timeSlotAppointment: $timeSlotAppointment');
      emit(AppointmentInitial());
    } catch (e) {
      emit(AppointmentAvailableSlotsError(e.toString()));
      AppointmentState.timeSlotAppointment =
          const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);
      AppointmentState.pets = [];
    }
  }

  void _onInitDates(
      AppointmentInitDatesEvent event, Emitter<AppointmentState> emit) {
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
    }

    if (activeDates.isEmpty) {
      emit(
          const AppointmentAvailableDaysOfWeekError('График работы не найден'));
      return;
    }
    AppointmentState.activeDates = activeDates;
    AppointmentState.timeSlotAppointment =
        const TimeSlotAppointment(availableTimeSlot: [], allTimeSlot: []);

    emit(AppointmentInitial());
  }
}
