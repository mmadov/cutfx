part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class UserDataFoundState extends ProfileState {
  final SalonUser salonUser;

  UserDataFoundState(this.salonUser);
}
