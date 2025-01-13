part of 'service_bloc.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();
  
  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServiceLoaded extends ServiceState {
  final List<Service> services;

  const ServiceLoaded({required this.services});

  @override
  List<Object> get props => [services];
}

final class ServiceLoadedError extends ServiceState {
  final String message;

  const ServiceLoadedError({required this.message});

  @override
  List<Object> get props => [message];
}

final class ServiceEmpty extends ServiceState {}
