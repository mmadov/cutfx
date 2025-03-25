import 'package:cutfx/bloc/salon/salon_details_bloc.dart';
import 'package:cutfx/model/user/salon.dart';
import 'package:cutfx/screens/gallery/gallery_screen.dart';
import 'package:cutfx/utils/const_res.dart';
import 'package:cutfx/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/route_manager.dart';

class SalonGalleryPage extends StatelessWidget {
  const SalonGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalonDetailsBloc salonDetailsBloc = context.read<SalonDetailsBloc>();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        axisDirection: AxisDirection.down,
        children: List.generate(
          salonDetailsBloc.salonData?.gallery?.length ?? 0,
          (index) {
            Gallery? gallery = salonDetailsBloc.salonData?.gallery?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: AspectRatio(
                aspectRatio: (index % 2) == 1 ? 1 / 1 : 1 / 1.5,
                child: InkWell(
                  onTap: () => Get.to(() => const GalleryScreen(), arguments: {
                    ConstRes.salonData: salonDetailsBloc.salonData,
                    ConstRes.gallery: gallery
                  }),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: FadeInImage.assetNetwork(
                      image: '${ConstRes.itemBaseUrl}${gallery?.image}',
                      fit: BoxFit.cover,
                      imageErrorBuilder: errorBuilderForImage,
                      placeholderErrorBuilder: loadingImage,
                      placeholder: '1',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
