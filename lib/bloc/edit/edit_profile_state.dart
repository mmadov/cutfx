part of 'edit_profile_bloc.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class UserDataFoundState extends EditProfileState {
  final SalonUser salonUser;

  UserDataFoundState(this.salonUser);
}
