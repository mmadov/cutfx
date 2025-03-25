import 'dart:ui';

import 'package:custom_marker/marker_icon.dart';
import 'package:cutfx/model/cat/categories.dart';
import 'package:cutfx/model/salonbycoordinates/salon_by_coordinates.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as g_map;

part 'salon_on_map_event.dart';
part 'salon_on_map_state.dart';

class SalonOnMapBloc extends Bloc<SalonOnMapEvent, SalonOnMapState> {
  SalonOnMapBloc() : super(SalonOnMapInitial()) {
    manager = _initClusterManager();
    on<FetchSalonOnMapEvent>((event, emit) async {
      SalonByCoordinates salonByCoordinates = await ApiService()
          .fetchSalonByCoordinates(
              lat: position.latitude.toString(),
              long: position.longitude.toString(),
              catID: selectedIndex);
      salons = salonByCoordinates.data ?? [];

      items = [];
      SharePref sharePref = await SharePref().init();
      if (categories.isEmpty) {
        categories = sharePref.getSettings()?.data?.categories ?? [];
      }
      userData = sharePref.getSalonUser()?.data;
      widgets = List.generate(
        salons.length,
        (index) {
          String imageUrl =
              ConstRes.itemBaseUrl + (salons[index].images?[0].image ?? '');
          GlobalKey globalKey1 = GlobalKey();
          globalKey[imageUrl] = globalKey1;

          return CustomMarker(imageUrl: imageUrl, globalKey: globalKey1);
        },
      );
      for (int i = 0; i < salons.length; i++) {
        items.add(
          Place(
            salon: salons[i],
            latLng: g_map.LatLng(
              double.parse(salons[i].salonLat!),
              double.parse(salons[i].salonLong!),
            ),
          ),
        );
      }
      manager.setItems(items);
      emit(DataFoundSalonOnMapState());
    });
    on<UpdateSalonOnMapEvent>((event, emit) async {
      emit(UpdateDataMapState());
    });
  }

  int selectedDistance = 10;
  List<int> distanceList = [1, 5, 10, 20, 50, 500];
  g_map.LatLng center = const g_map.LatLng(21.2408, 72.8806);
  Set<g_map.Marker> marker = {};
  List<Place> items = [];
  late g_map.GoogleMapController mapController;
  late ClusterManager manager;
  late Position position;
  UserData? userData;
  List<Widget> widgets = [];
  List<CategoryData> categories = [];
  int selectedIndex = -1;
  List<SalonData> salons = [];

  ClusterManager _initClusterManager() {
    return ClusterManager<Place>(
      items,
      _updateMarkers,
      markerBuilder: _markerBuilder,
      levels: [1, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5, 20.0],
      extraPercent: 0.2,
    );
  }

  void _updateMarkers(Set<g_map.Marker> markers) {
    marker = markers;
    add(UpdateSalonOnMapEvent());
  }

  PageController pageController = PageController();

  Future<g_map.Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return g_map.Marker(
          markerId: g_map.MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            for (var salon in cluster.items) {
              for (int i = 0; i < items.length; i++) {
                if (salon.salon?.id == items[i].salon?.id) {
                  pageController.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              }
            }
          },
          icon: await _getMarkerBitmap(
              cluster.isMultiple ? 125 : 75, cluster.items.toList(),
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };
  Map<String, GlobalKey> globalKey = {};

  Future<g_map.BitmapDescriptor> _getMarkerBitmap(int size, List<Place> places,
      {String? text}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = ColorRes.themeColor;
    final Paint paint2 = Paint()..color = ColorRes.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    if (size == 75) {
      if (places[0].salon?.images == null || places[0].salon!.images!.isEmpty) {
        return await MarkerIcon.pictureAsset(
            width: 110, height: 110, assetPath: AssetRes.icPersonLocationPin);
      }

      return await MarkerIcon.widgetToIcon(globalKey[
          ConstRes.itemBaseUrl + (places[0].salon?.images?[0].image ?? '')]!);
    } else {
      return g_map.BitmapDescriptor.bytes(data.buffer.asUint8List());
    }
  }

  void onMapCreated(g_map.GoogleMapController controller) async {
    position = await getUserCurrentLocation();
    add(FetchSalonOnMapEvent());

    await SharePref.setLatLong(
      position.latitude.toString(),
      position.longitude.toString(),
    );
    center = g_map.LatLng(position.latitude, position.longitude);
    await controller.animateCamera(
      g_map.CameraUpdate.newCameraPosition(
        g_map.CameraPosition(
          target: center,
          zoom: 15.09,
        ),
      ),
    );
    mapController = controller;
    mapController.animateCamera(
      g_map.CameraUpdate.newLatLng(center),
    );
    add(UpdateSalonOnMapEvent());
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      // SnackBarWidget().snackBarWidget('$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<void> close() {
    mapController.dispose();
    return super.close();
  }
}

class Place with ClusterItem {
  final SalonData? salon;
  final g_map.LatLng latLng;

  Place({
    required this.salon,
    required this.latLng,
  });

  @override
  g_map.LatLng get location => latLng;
}

class CustomMarker extends StatefulWidget {
  final String imageUrl;
  final GlobalKey globalKey;

  const CustomMarker({
    super.key,
    required this.imageUrl,
    required this.globalKey,
  });

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.globalKey,
      child: SizedBox(
        width: 160,
        child: Stack(
          children: [
            const SizedBox(
              width: 160,
              child: Image(
                image: AssetImage(
                  AssetRes.icPersonLocationPin,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 19),
                child: SizedBox(
                  height: 90,
                  width: 90,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: '1',
                      image: widget.imageUrl,
                      fit: BoxFit.cover,
                      placeholderErrorBuilder: loadingImage,
                      imageErrorBuilder: errorBuilderForImage,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
