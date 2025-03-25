part of 'service_details_bloc.dart';

abstract class ServiceDetailsState {}

class ServiceDetailsInitial extends ServiceDetailsState {}

class ServiceDetailsDataFoundState extends ServiceDetailsState {
  final ServiceDetails serviceDetails;

  ServiceDetailsDataFoundState(this.serviceDetails);
}
