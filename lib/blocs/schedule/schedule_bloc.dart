import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/appointment/appointment.dart';
import 'package:pet_style_mobile/src/domain/repository/appointment_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final AppointmentRepository _appointmentRepository;
  ScheduleBloc(this._appointmentRepository) : super(ScheduleInitial()) {
    on<ScheduleLoad>(_onScheduleLoad);
    on<ScheduleCancelEvent>(_onScheduleCancelEvent);
    on<ScheduleEditEvent>(_onScheduleEditEvent);
  }

  FutureOr<void> _onScheduleLoad(
      ScheduleLoad event, Emitter<ScheduleState> emit) async {
    try {
      if (state is! ScheduleLoaded) {
        emit(ScheduleLoading());
      }
      final List<Appointment> all =
          await _appointmentRepository.getAppointmentsByUser();
      final List<Appointment> active = all
          .where((element) =>
              element.status == 0 &&
              element.appointmentDate!
                  .isAfter(DateTime.now().subtract(const Duration(hours: 12))))
          .toList()
        ..sort((a, b) => a.appointmentDate!.compareTo(b.appointmentDate!));
      final List<Appointment> completed = all
          .where((element) => element.status == 1)
          .toList()
        ..sort((a, b) => a.appointmentDate!.compareTo(b.appointmentDate!));
      final List<Appointment> canceled = all
          .where((element) => element.status == 2)
          .toList()
        ..sort((a, b) => a.appointmentDate!.compareTo(b.appointmentDate!));
      emit(ScheduleLoaded(active, completed, canceled));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    } finally {
      event.completer?.complete();
    }
  }

  FutureOr<void> _onScheduleCancelEvent(
      ScheduleCancelEvent event, Emitter<ScheduleState> emit) async {
    emit(ScheduleCanceling());
    try {
      await _appointmentRepository.cancelAppointment(event.appointmentId);
      emit(ScheduleCanceled());
    } catch (e) {
      emit(ScheduleCancelError(e.toString(), event.appointmentId));
    }
  }

  FutureOr<void> _onScheduleEditEvent(
      ScheduleEditEvent event, Emitter<ScheduleState> emit) async {
    emit(EditChecking());
    try {
      final Appointment? appointment = await _appointmentRepository
          .isAvailableEditAppointment(event.appointmentId);
      if (appointment != null) {
        emit(EditingAvailable(appointment));
      } else {
        emit(EditingNotAvailable());
      }
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}
