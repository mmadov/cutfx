import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/home/home_page_data.dart' as home_data;

part 'top_rated_salon_event.dart';
part 'top_rated_salon_state.dart';

class TopRatedSalonBloc extends Bloc<TopRatedSalonEvent, TopRatedSalonState> {
  TopRatedSalonBloc() : super(TopRatedSalonInitial()) {
    if (Get.arguments != null && Get.arguments is List<SalonData>) {
      salons = Get.arguments;
      duplicateSalons = salons;
      searchController.addListener(() {
        String keyword = searchController.text;
        salons = [];
        for (SalonData salonData in duplicateSalons) {
          if ((salonData.salonName?.toLowerCase() ?? '')
                  .contains(keyword.toLowerCase()) ||
              (salonData.salonAddress?.toLowerCase() ?? '')
                  .contains(keyword.toLowerCase()) ||
              (salonData.getCatInString().toLowerCase())
                  .contains(keyword.toLowerCase())) {
            salons.add(salonData);
          }
        }
        add(UpdateTopRatedSalon());
      });
    } else {
      on<FetchTopRatedSalon>((event, emit) async {
        SalonByCoordinates service =
            await ApiService().searchTopRatedSalonsOfCategory(
          keyword: keyword,
          start: salons.length,
          catId: catId,
        );
        salons = service.data ?? [];
        duplicateSalons = salons;
        emit(FoundTopRatedSalonDataState());
      });
      home_data.Categories category = Get.arguments;
      setCatId(category.id?.toString() ?? '');
      searchController.addListener(() {
        if (keyword != searchController.text) {
          keyword = searchController.text;
        }
        salons = [];
        add(FetchTopRatedSalon());
      });
      scrollController.addListener(() {
        if (scrollController.offset ==
                scrollController.position.maxScrollExtent &&
            !isFetching) {
          add(FetchTopRatedSalon());
        }
      });
    }
    on<UpdateTopRatedSalon>((event, emit) async {
      emit(FoundTopRatedSalonDataState());
    });
  }

  bool isFetching = false;
  ScrollController scrollController = ScrollController();
  String? catId;
  String keyword = '';
  List<SalonData> salons = [];
  List<SalonData> duplicateSalons = [];
  TextEditingController searchController = TextEditingController();

  void setCatId(String? value) {
    catId = value;
    salons = [];
    add(FetchTopRatedSalon());
  }
}
