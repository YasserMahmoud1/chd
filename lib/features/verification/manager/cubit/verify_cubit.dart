import 'package:bloc/bloc.dart';
import 'package:chd/core/api_manager.dart';
import 'package:chd/core/cookie_manager.dart';
import 'package:chd/core/function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyInitial());

  static VerifyCubit get(context) => BlocProvider.of(context);

  verify(int otp, String phone) async {
    emit(VerifyLoading());
    try {
    final String? identity = await getId();
    var r = await ApiManager().post(
        "http://165.22.201.156/api/app/auth/verify?phone=${int.parse(phone.substring(1))}&identity=$identity&fcm_token=$identity&otp=$otp");
    print(r);
    await CookieManager().saveToken(r["access_token"]);
    emit(VerifySuccess());
    } catch (e) {
      print(e.toString());
      emit(VerifyFailure());
    }
  }
}
