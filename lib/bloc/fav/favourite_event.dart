abstract class FavouriteEvent {}

class OnTabClickEvent extends FavouriteEvent {
  final int selectedIndex;

  OnTabClickEvent(this.selectedIndex);
}

class FetchFavouriteDataEvent extends FavouriteEvent {}
