import 'package:cutfx/model/review/salon_review.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'review_event.dart';

part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewInitial()) {
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchReviewEvent(-1));
      }
    });
    on<FetchReviewEvent>((event, emit) async {
      SalonReview salonReview =
          await ApiService().fetchSalonReviews(Get.arguments, reviews.length);
      reviews.addAll(salonReview.data ?? []);
      emit(ReviewDataFetchedState());
    });
    add(FetchReviewEvent(-1));
  }

  ScrollController scrollController = ScrollController();
  bool isFetching = false;
  int count = 0;
  List<ReviewData> reviews = [];
}
