import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/src/data/model/services/service.dart';
import 'package:pet_style_mobile/src/domain/repository/service_repository.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository _serviceRepository;
  ServiceBloc(this._serviceRepository) : super(ServiceInitial()) {
    on<ServiceFetchEvent>(_onServiceFetchEvent);
  }

  Future<void> _onServiceFetchEvent(
      ServiceFetchEvent event, Emitter<ServiceState> emit) async {
    if (state is! ServiceLoaded) {
      emit(ServiceLoading());
    }
    try {
      final List<Service> services = await _serviceRepository.getAll();
      if (services.isEmpty) {
        emit(ServiceEmpty());
        return;
      }
      emit(ServiceLoaded(services: services));
    } catch (e) {
      emit(ServiceLoadedError(message: e.toString()));
      
    }
  }
}
