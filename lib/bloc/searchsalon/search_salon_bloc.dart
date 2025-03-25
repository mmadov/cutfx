import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_salon_event.dart';
part 'search_salon_state.dart';

class SearchSalonBloc extends Bloc<SearchSalonEvent, SearchSalonState> {
  SearchSalonBloc() : super(SearchSalonInitial()) {
    on<FetchSalonEvent>((event, emit) async {
      if (recentSearch.isEmpty) {
        SharePref sharePref = await SharePref().init();
        recentSearch = sharePref.getString(ConstRes.salon)!.isNotEmpty
            ? sharePref.getString(ConstRes.salon)!.split(",")
            : [];
      }
      if (salons.isEmpty) {
        emit(SearchSalonInitial());
      }
      SalonByCoordinates salon = await ApiService().searchSalon(
        keyword: searchController.text.toString(),
        start: salons.length,
        catId: catId,
      );
      salons.addAll(salon.data ?? []);
      isFetching = false;
      emit(SalonDataFoundState());
    });
    on<UpdateDataRecentDataEvent>((event, emit) async {
      emit(SalonDataFoundState());
    });
    searchController.addListener(() {
      if (!isFetching) {
        isFetching = true;
        salons = [];
        add(FetchSalonEvent());
      }
    });
    add(FetchSalonEvent());
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchSalonEvent());
      }
    });
  }

  bool isFetching = false;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  String? catId;
  List<SalonData> salons = [];
  List<String> recentSearch = [];
  FocusNode focusNode = FocusNode();

  void setCatId(String? value) {
    catId = value;
    salons = [];
    add(FetchSalonEvent());
  }

  void onTaOutsideOfTextField() async {
    SharePref sharePref = await SharePref().init();
    if (searchController.text.isNotEmpty &&
        !recentSearch.contains(searchController.text)) {
      recentSearch.insert(0, searchController.text);
    }
    sharePref.saveString(
      ConstRes.salon,
      recentSearch.join(","),
    );
    focusNode.unfocus(disposition: UnfocusDisposition.scope);
  }

  void deleteRecentSearch(String data) async {
    SharePref sharePref = await SharePref().init();
    if (recentSearch.contains(data)) {
      recentSearch.remove(data);
    }

    sharePref.saveString(
      ConstRes.salon,
      recentSearch.join(","),
    );
    focusNode.unfocus(disposition: UnfocusDisposition.scope);
    add(UpdateDataRecentDataEvent());
  }

  void clearAll() async {
    SharePref sharePref = await SharePref().init();
    recentSearch.clear();

    sharePref.saveString(
      ConstRes.salon,
      recentSearch.join(","),
    );
    focusNode.unfocus(disposition: UnfocusDisposition.scope);
    add(UpdateDataRecentDataEvent());
  }

  @override
  Future<void> close() {
    onTaOutsideOfTextField();
    return super.close();
  }
}
