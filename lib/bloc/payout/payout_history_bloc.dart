import 'package:cutfx/model/withdrawrequest/withdraw_requests.dart';
import 'package:cutfx/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payout_history_event.dart';
part 'payout_history_state.dart';

class PayoutHistoryBloc extends Bloc<PayoutHistoryEvent, PayoutHistoryState> {
  PayoutHistoryBloc() : super(PayoutHistoryInitial()) {
    on<FetchPayoutHistoryEvent>((event, emit) async {
      WithdrawRequests withdrawRequest =
          await ApiService().fetchUserWithdrawRequests(
        start: withdrawRequests.length,
      );
      withdrawRequests.addAll(withdrawRequest.data ?? []);
      emit(PayoutHistoryDataFoundState());
    });
    add(FetchPayoutHistoryEvent());
  }

  List<WithdrawRequestsData> withdrawRequests = [];
}
