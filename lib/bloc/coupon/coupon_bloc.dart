import 'package:cutfx/model/coupon/coupon.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coupon_event.dart';

part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    on<FetchCouponDataEvent>((event, emit) async {
      Coupon coupon = await ApiService().fetchCoupons();
      coupons = coupon.data ?? [];
      emit(CouponDataFoundState());
    });
    add(FetchCouponDataEvent());
  }

  List<CouponData>? coupons;
}
