abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchChangeTabState extends SearchState {
  final int selectedIndex;

  SearchChangeTabState(this.selectedIndex);
}
