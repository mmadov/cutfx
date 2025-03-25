part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeDataFoundState extends HomeState {
  final HomePageData? homePageData;

  HomeDataFoundState(this.homePageData);
}
