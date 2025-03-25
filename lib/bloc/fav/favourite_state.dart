import 'package:cutfx/model/fav/favourite_data.dart';

abstract class FavouriteState {}

class FavouriteInitialState extends FavouriteState {}

class ChangeTabState extends FavouriteState {
  final int selectedIndex;

  ChangeTabState(this.selectedIndex);
}

class FavouriteDataFound extends FavouriteState {
  final FavouriteData favouriteData;

  FavouriteDataFound(this.favouriteData);
}
