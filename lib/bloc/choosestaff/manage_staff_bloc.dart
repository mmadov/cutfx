import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/app_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

part 'manage_staff_event.dart';
part 'manage_staff_state.dart';

class ManageStaffBloc extends Bloc<ManageStaffEvent, ManageStaffState> {
  ManageStaffBloc(this.salonData) : super(ManageStaffInitial()) {
    on<FetchManageStaffEvent>((event, emit) {
      emit(FetchStaffState());
    });
    on<SelectStaffEvent>(
      (event, emit) {
        emit(SelectStaffState());
      },
    );
    fetchStaff();
    searchController.addListener(
      () {
        staffs = dummyStaffs
            ?.where(
              (element) =>
                  element.name
                      ?.toLowerCase()
                      .contains(searchController.text.toLowerCase()) ==
                  true,
            )
            .toList();
        add(FetchManageStaffEvent());
      },
    );
  }

  List<StaffData>? staffs = [];
  List<StaffData>? dummyStaffs = [];
  StaffData? selectedStaff;
  TextEditingController searchController = TextEditingController();
  SalonData? salonData;
  void fetchStaff() async {
    var staff = await ApiService()
        .fetchAllStaffOfSalon(salonId: salonData?.id?.toInt() ?? -1);
    staffs = staff.data
        ?.where(
          (element) => element.status?.toInt() == 1,
        )
        .toList();
    dummyStaffs = staffs;
    add(FetchManageStaffEvent());
  }

  void onClickBarber(int index) {
    selectedStaff = staffs?[index];
    Get.back(result: selectedStaff);
    // add(SelectStaffEvent());
  }

  void confirmBarber() {
    if (selectedStaff == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.chooseBarberFirst, false);
      return;
    }
    Get.back(result: selectedStaff);
    // Map<String, dynamic> arguments = Get.arguments;
    // arguments[ConstRes.staffData] = selectedStaff;
    // Get.to(
    //   () => const MakePaymentScreen(),
    //   arguments: arguments,
    // );
  }
}
