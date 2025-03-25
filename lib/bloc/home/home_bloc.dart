import 'package:cutfx/model/home/home_page_data.dart';
import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeDataEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      salonUser = sharePref.getSalonUser();
      homePageData = await ApiService().fetchHomePageData();
      fetchLocation();
      emit(HomeDataFoundState(homePageData));
    });
    on<FetchNearBySalonEvent>((event, emit) async {
      emit(HomeDataFoundState(homePageData));
    });
    add(FetchHomeDataEvent());
  }

  SalonUser? salonUser;
  List<SalonData> salons = [];
  HomePageData? homePageData;

  void fetchLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      // SnackBarWidget().snackBarWidget('$error');
    });

    Position position = await Geolocator.getCurrentPosition();
    AppRes.longitude = position.longitude;
    AppRes.latitude = position.latitude;
    SalonByCoordinates salonByCoordinates =
        await ApiService().fetchSalonByCoordinates(
      lat: position.latitude.toString(),
      long: position.longitude.toString(),
    );
    salons = salonByCoordinates.data ?? [];
    add(FetchNearBySalonEvent());
  }
}
