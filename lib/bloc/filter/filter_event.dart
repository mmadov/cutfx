part of 'filter_bloc.dart';

abstract class FilterEvent {}

class FetchCategoriesDataEvent extends FilterEvent {
  final String selectedId;

  FetchCategoriesDataEvent(this.selectedId);
}
