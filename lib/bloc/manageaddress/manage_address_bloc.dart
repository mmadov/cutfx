import 'package:cutfx/model/address/address.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

part 'manage_address_event.dart';
part 'manage_address_state.dart';

class ManageAddressBloc extends Bloc<ManageAddressEvent, ManageAddressState> {
  ManageAddressBloc() : super(ManageAddressInitial()) {
    on<ManageAddressEvent>((event, emit) {});
    on<FetchAddressEvent>(
      (event, emit) {
        emit(DataFoundAddressState());
      },
    );
    fetchMyAddress();
  }

  List<AddressData> addresses = [];
  bool isLoading = true;
  bool isEnabledSelect = Get.arguments == null ? false : true;

  void fetchMyAddress() {
    isLoading = true;
    ApiService().fetchMyAddress().then(
      (value) {
        isLoading = false;
        addresses = value.data ?? [];
        add(FetchAddressEvent());
      },
    );
  }

  void deleteAddress(AddressData addressData) async {
    AppRes.showCustomLoader();
    await ApiService().deleteUserAddress(addressData.id?.toInt() ?? -1).then(
      (value) {
        AppRes.hideCustomLoader();
        fetchMyAddress();
      },
    );
  }
}
