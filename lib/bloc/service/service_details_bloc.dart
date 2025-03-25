import 'package:cutfx/model/service/services_details.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../model/user/salon.dart';

part 'service_details_event.dart';
part 'service_details_state.dart';

class ServiceDetailsBloc
    extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  ServiceDetailsBloc() : super(ServiceDetailsInitial()) {
    on<FetchServiceDetailsEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      userData = sharePref.getSalonUser()?.data;
      ServiceDetails serviceDetails =
          await ApiService().fetchService(Get.arguments);
      selectedServices.add(Services.fromJson(serviceDetails.data?.toJson()));
      emit(ServiceDetailsDataFoundState(serviceDetails));
    });
    add(FetchServiceDetailsEvent());
  }

  List<Services> selectedServices = [];
  UserData? userData;
}
