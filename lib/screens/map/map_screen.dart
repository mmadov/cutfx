import 'package:cutfx/screens/map/map_screen_controller.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final LatLng latLng;

  const MapScreen({
    super.key,
    required this.latLng,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapScreenController(latLng));
    return Scaffold(
      body: GetBuilder(
        init: controller,
        builder: (controller1) {
          return Column(
            children: [
              const ToolBarWidget(title: 'Map Screen'),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      onTap: (argument) {
                        controller.getCameraPosition(latLng: argument);
                      },
                      initialCameraPosition:
                          const CameraPosition(target: LatLng(0, 0), zoom: 16),
                      markers: Set<Marker>.of(controller.markers.toSet()),
                      mapType: MapType.normal,
                      myLocationEnabled: false,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController c) {
                        controller.mapController.complete(c);
                      },
                    ),
                    SafeArea(
                      top: false,
                      child: InkWell(
                        onTap: controller.onDoneClick,
                        child: Container(
                          height: 45,
                          width: Get.width / 3,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              color: ColorRes.themeColor,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: SafeArea(
                            top: false,
                            child: Text(
                              AppLocalizations.of(context)!.done,
                              style: kSemiBoldTextStyle.copyWith(
                                color: ColorRes.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: controller.getUserCurrentLocation,
        backgroundColor: ColorRes.themeColor,
        child: const Icon(
          Icons.location_on,
        ),
      ),
    );
  }
}
