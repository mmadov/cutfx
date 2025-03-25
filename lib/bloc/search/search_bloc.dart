import 'package:cutfx/bloc/search/search_event.dart';
import 'package:cutfx/bloc/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchOnTabClickEvent>(
      (event, emit) async {
        emit(SearchChangeTabState(event.selectedIndex));
      },
    );
  }
}
