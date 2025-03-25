import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/cat/categories.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FetchCategoriesDataEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      categories = sharePref.getSettings()?.data?.categories ?? [];
      selectedIndex = event.selectedId.toString();
      emit(CategoriesFetchedState());
    });
  }

  List<CategoryData> categories = [];
  String selectedIndex = '-1';
}
