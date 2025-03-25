import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/staff/staff.dart';
import 'package:cutfx/screens/barber/choose_barber_screen.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalonStaffPage extends StatefulWidget {
  const SalonStaffPage({super.key});

  @override
  State<SalonStaffPage> createState() => _SalonStaffPageState();
}

class _SalonStaffPageState extends State<SalonStaffPage> {
  List<StaffData> staffs = [];
  var isLoading = true;

  @override
  void initState() {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    ApiService()
        .fetchAllStaffOfSalon(
            salonId: salonDetailsBloc.salonData?.id?.toInt() ?? -1)
        .then(
      (value) {
        isLoading = false;
        if (value.data != null) {
          staffs = value.data
                  ?.where(
                    (element) => element.status == 1,
                  )
                  .toList() ??
              [];
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorRes.themeColor,
            ),
          )
        : staffs.isEmpty
            ? const Center(child: DataNotFound())
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                itemCount: staffs.length,
                itemBuilder: (context, index) {
                  return ItemStaff(staffData: staffs[index], isSelected: false);
                },
              );
  }
}
