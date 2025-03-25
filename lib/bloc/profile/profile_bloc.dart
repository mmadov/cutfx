import 'package:cutfx/model/user/salon_user.dart';
import 'package:cutfx/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      SharePref sharePref = await SharePref().init();
      SalonUser? salonUser = sharePref.getSalonUser();
      if (salonUser != null) {
        emit(UserDataFoundState(salonUser));
      }
    });
    add(FetchUserDataEvent());
  }
}
