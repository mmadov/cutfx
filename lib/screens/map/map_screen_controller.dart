import 'dart:async';
import 'dart:ui' as ui;

import 'package:cutfx/utils/app_res.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as p;

class MapScreenController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  List<Marker> markers = <Marker>[];
  LatLng latLng;
  Location location = Location();

  MapScreenController(this.latLng);

  @override
  void onReady() {
    getInitCameraPosition();
    super.onReady();
  }

  Future<void> getCameraPosition({required LatLng latLng}) async {
    final Uint8List markIcons = await getImages(AssetRes.icPin, 100);
    if (latLng == const LatLng(0, 0)) {
      return;
    }
    markers = <Marker>[];
    markers.add(
      Marker(
        markerId: const MarkerId('0'),
        position: latLng,
        icon: BitmapDescriptor.bytes(markIcons),
      ),
    );
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );
    this.latLng = latLng;
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    update();
  }

  void onDoneClick() {
    if (latLng == const LatLng(0, 0)) {
      Get.back();
    } else {
      Get.back(result: latLng);
    }
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void getUserCurrentLocation() async {
    HapticFeedback.heavyImpact();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await location.requestService();
        AppRes.showSnackBar(
            AppLocalizations.of(Get.context!)!.locationServiceIsDisabled,
            false);
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        p.openAppSettings();
        return;
      }
    }
    AppRes.showCustomLoader();
    LocationData position = await location.getLocation();
    Get.back();

    getCameraPosition(
      latLng: LatLng(position.latitude ?? 0, position.longitude ?? 0),
    );
  }

  void getInitCameraPosition() {
    if (latLng == const LatLng(0, 0)) {
      getUserCurrentLocation();
    } else {
      getCameraPosition(latLng: latLng);
    }
  }
}
