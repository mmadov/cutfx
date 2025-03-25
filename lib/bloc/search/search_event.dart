abstract class SearchEvent {}

class SearchOnTabClickEvent extends SearchEvent {
  final int selectedIndex;

  SearchOnTabClickEvent(this.selectedIndex);
}
