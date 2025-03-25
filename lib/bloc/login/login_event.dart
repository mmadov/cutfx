part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginClickEvent extends LoginEvent {
  final int type;

  LoginClickEvent(this.type);
}
