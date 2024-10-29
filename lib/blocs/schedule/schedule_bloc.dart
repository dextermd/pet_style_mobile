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
          .where((element) => element.status == 0)
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
}
