part of 'review_bloc.dart';

abstract class ReviewEvent {}

class FetchReviewEvent extends ReviewEvent {
  final int salonId;

  FetchReviewEvent(this.salonId);
}
