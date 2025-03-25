import 'package:cutfx/bloc/salononmap/salon_on_map_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/fav/salon_screen.dart';
import 'package:cutfx/utils/asset_res.dart';
import 'package:cutfx/utils/color_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:cutfx/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SalonOnMapScreen extends StatelessWidget {
  const SalonOnMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalonOnMapBloc(),
      child: Scaffold(
        body: BlocBuilder<SalonOnMapBloc, SalonOnMapState>(
          builder: (context, state) {
            SalonOnMapBloc salonOnMapBloc = context.read<SalonOnMapBloc>();
            return Stack(
              children: [
                Visibility(
                  visible: true,
                  child: Column(
                    children: salonOnMapBloc.widgets,
                  ),
                ),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      salonOnMapBloc.mapController = controller;
                      salonOnMapBloc.onMapCreated(controller);
                      salonOnMapBloc.manager.setMapId(controller.mapId);
                    },
                    mapToolbarEnabled: false,
                    onCameraMove: salonOnMapBloc.manager.onCameraMove,
                    onCameraIdle: salonOnMapBloc.manager.updateMap,
                    markers: salonOnMapBloc.marker,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                    indoorViewEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: salonOnMapBloc.center,
                      zoom: 15.4746,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: AspectRatio(
                      aspectRatio: 1 / .45,
                      child: PageView.builder(
                        controller: salonOnMapBloc.pageController,
                        onPageChanged: (value) {
                          SalonData salonData = salonOnMapBloc.salons[value];
                          if (salonData.salonLat != null) {
                            salonOnMapBloc.mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                LatLng(
                                  double.parse(salonData.salonLat!),
                                  double.parse(salonData.salonLong!),
                                ),
                                17,
                              ),
                            );
                          }
                        },
                        allowImplicitScrolling: true,
                        itemCount: salonOnMapBloc.salons.length,
                        itemBuilder: (context, index) {
                          SalonData salonData = salonOnMapBloc.salons[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ItemSalon(
                              salonData: salonData,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        CustomCircularInkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: const BoxDecoration(
                                color: ColorRes.themeColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: const Image(
                              image: AssetImage(AssetRes.icBack),
                              height: 30,
                              color: ColorRes.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const CategoriesFilterMapWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoriesFilterMapWidget extends StatefulWidget {
  const CategoriesFilterMapWidget({super.key});

  @override
  State<CategoriesFilterMapWidget> createState() =>
      _CategoriesFilterMapWidgetState();
}

class _CategoriesFilterMapWidgetState extends State<CategoriesFilterMapWidget> {
  late SalonOnMapBloc salonOnMapBloc;

  @override
  void initState() {
    salonOnMapBloc = context.read<SalonOnMapBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SalonOnMapBloc, SalonOnMapState>(
        builder: (context, state) {
          return Center(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: true,
              children: List<Widget>.generate(
                salonOnMapBloc.categories.length,
                (index) => ItemFilterWidget(
                  title: salonOnMapBloc.categories[index].title ?? '',
                  filterIsSelected: salonOnMapBloc.selectedIndex ==
                      salonOnMapBloc.categories[index].id,
                  onTap: () {
                    salonOnMapBloc.selectedIndex =
                        salonOnMapBloc.categories[index].id ?? -1;
                    salonOnMapBloc.add(FetchSalonOnMapEvent());
                    setState(() {});
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemFilterWidget extends StatelessWidget {
  final String title;
  final bool filterIsSelected;
  final Function()? onTap;

  const ItemFilterWidget({
    super.key,
    required this.title,
    required this.filterIsSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: filterIsSelected ? ColorRes.lavender : ColorRes.smokeWhite,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(
            color: filterIsSelected ? ColorRes.themeColor : ColorRes.empress,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(
          right: 10,
          top: 5,
          bottom: 5,
        ),
        child: Center(
          child: Text(
            title,
            style: kSemiBoldTextStyle.copyWith(
              fontSize: 14,
              color: filterIsSelected ? ColorRes.themeColor : ColorRes.empress,
            ),
          ),
        ),
      ),
    );
  }
}
