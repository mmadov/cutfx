import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/home/top_rated_salon.dart';
import 'package:flutter/material.dart';

class NearBySalonsWidget extends StatelessWidget {
  const NearBySalonsWidget({
    super.key,
    required this.nearBySalons,
  });
  final List<SalonData> nearBySalons;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ListView.builder(
        itemCount: nearBySalons.length > 5 ? 5 : nearBySalons.length,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          SalonData salonData = nearBySalons[index];
          return ItemTopRatedSalon(salonData);
        },
      ),
    );
  }
}
