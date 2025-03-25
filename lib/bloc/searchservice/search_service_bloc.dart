import 'package:cutfx/model/service/services.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_service_event.dart';
part 'search_service_state.dart';

class SearchServiceBloc extends Bloc<SearchServiceEvent, SearchServiceState> {
  SearchServiceBloc() : super(SearchServiceInitial()) {
    on<FetchServiceEvent>((event, emit) async {
      if (recentSearch.isEmpty) {
        SharePref sharePref = await SharePref().init();
        recentSearch =
            sharePref.getString(ConstRes.services)?.isNotEmpty == true
                ? sharePref.getString(ConstRes.services)!.split(",")
                : [];
      }
      if (services.isEmpty) {
        emit(SearchServiceInitial());
      }
      Services service = await ApiService().searchServices(
        keyword: searchController.text.toString(),
        start: services.length,
        catId: catId,
      );
      isFetching = false;
      services.addAll(service.data ?? []);
      emit(ServiceDataFoundState());
    });
    on<UpdateDataSearchServiceEvent>((event, emit) async {
      emit(ServiceDataFoundState());
    });
    searchController.addListener(() {
      if (!isFetching) {
        services = [];
        isFetching = true;
        add(FetchServiceEvent());
      }
    });
    add(FetchServiceEvent());
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchServiceEvent());
      }
    });
  }

  bool isFetching = false;
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  String? catId;
  List<ServiceData> services = [];
  List<String> recentSearch = [];
  FocusNode focusNode = FocusNode();

  void setCatId(String? value) {
    catId = value;
    services = [];
    add(FetchServiceEvent());
  }

  void onTaOutsideOfTextField() async {
    SharePref sharePref = await SharePref().init();
    if (searchController.text.isNotEmpty &&
        !recentSearch.contains(searchController.text)) {
      recentSearch.insert(0, searchController.text);
    }
    sharePref.saveString(
      ConstRes.services,
      recentSearch.join(","),
    );
    focusNode.unfocus();
  }

  void deleteRecentSearch(String data) async {
    SharePref sharePref = await SharePref().init();
    if (recentSearch.contains(data)) {
      recentSearch.remove(data);
    }

    sharePref.saveString(
      ConstRes.services,
      recentSearch.join(","),
    );
    focusNode.unfocus();
    add(UpdateDataSearchServiceEvent());
  }

  void clearAll() async {
    SharePref sharePref = await SharePref().init();
    recentSearch.clear();

    sharePref.saveString(
      ConstRes.salon,
      recentSearch.join(","),
    );
    focusNode.unfocus();
    add(UpdateDataSearchServiceEvent());
  }

  @override
  Future<void> close() {
    onTaOutsideOfTextField();
    return super.close();
  }
}
