part of 'email_login_bloc.dart';

abstract class EmailLoginState {}

class EmailLoginInitial extends EmailLoginState {}

class EmailLoginLoadingState extends EmailLoginState {}

class EmailLoginResultState extends EmailLoginState {}
