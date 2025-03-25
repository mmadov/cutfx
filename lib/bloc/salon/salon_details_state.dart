part of 'salon_details_bloc.dart';

abstract class SalonDetailsState {}

class SalonDetailsInitial extends SalonDetailsState {}

class SalonDataFetched extends SalonDetailsState {
  final Salon salon;

  SalonDataFetched(this.salon);
}
