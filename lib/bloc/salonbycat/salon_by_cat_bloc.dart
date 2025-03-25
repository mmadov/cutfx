import 'package:cutfx/model/salonbycat/salon_by_cat.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/home/home_page_data.dart' as home_data;

part 'salon_by_cat_event.dart';
part 'salon_by_cat_state.dart';

class SalonByCatBloc extends Bloc<SalonByCatEvent, SalonByCatState> {
  SalonByCatBloc() : super(SalonByCatInitial()) {
    on<FetchSalonByCatEvent>((event, emit) async {
      if (salonByCat == null) {
        salonByCat = await ApiService()
            .salonAndServiceByCategory(category.id?.toInt() ?? -1);
        topRatedSalons = salonByCat?.data?.topRatedSalons ?? [];
        dupTopRatedSalons = topRatedSalons;
        services = salonByCat?.data?.services ?? [];
        dupServices = salonByCat?.data?.services ?? [];
      }
      keyword = searchController.text;
      if (keyword.isEmpty) {
        topRatedSalons = dupTopRatedSalons;
        services = dupServices;
      } else {
        for (SalonData salonData in dupTopRatedSalons) {
          if (salonData.salonName!
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              salonData.salonAddress!
                  .toLowerCase()
                  .contains(keyword.toLowerCase())) {
            topRatedSalons.add(salonData);
          }
        }
        for (Services salonData in dupServices) {
          if (salonData.title!.toLowerCase().contains(keyword.toLowerCase()) ||
              salonData.salonData!.salonName!
                  .toLowerCase()
                  .contains(keyword.toLowerCase())) {
            services.add(salonData);
          }
        }
      }
      emit(FetchSalonByCatState());
    });
    searchController.addListener(() {
      if (keyword != searchController.text) {
        topRatedSalons = [];
        services = [];
        add(FetchSalonByCatEvent());
      }
    });
    add(FetchSalonByCatEvent());
  }
  String keyword = '';
  SalonByCat? salonByCat;
  home_data.Categories category = Get.arguments;
  TextEditingController searchController = TextEditingController();
  List<SalonData> topRatedSalons = [];
  List<SalonData> dupTopRatedSalons = [];
  List<Services> dupServices = [];
  List<Services> services = [];
}
