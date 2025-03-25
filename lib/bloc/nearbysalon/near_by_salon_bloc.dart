import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'near_by_salon_event.dart';
part 'near_by_salon_state.dart';

class NearBySalonBloc extends Bloc<NearBySalonEvent, NearBySalonState> {
  NearBySalonBloc() : super(NearBySalonInitial()) {
    on<FetchNearBySalonEvent>((event, emit) async {
      SalonByCoordinates salonByCoordinates =
          await ApiService().fetchSalonByCoordinates(
        lat: AppRes.latitude.toString(),
        long: AppRes.longitude.toString(),
      );
      salons = salonByCoordinates.data ?? [];
      duplicateSalons = salons;
      emit(DataFoundNearBySalonState());
    });
    on<UpdateDataNearBySalonEvent>((event, emit) async {
      emit(DataFoundNearBySalonState());
    });
    nearBySalonEditingController.addListener(() {
      String keyword = nearBySalonEditingController.text;
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
      add(UpdateDataNearBySalonEvent());
    });
    add(FetchNearBySalonEvent());
  }

  List<SalonData> salons = [];
  List<SalonData> duplicateSalons = [];
  TextEditingController nearBySalonEditingController = TextEditingController();
}
