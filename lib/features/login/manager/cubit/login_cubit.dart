import 'package:bloc/bloc.dart';
import 'package:chd/core/api_manager.dart';
import 'package:chd/core/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  login(String phone, context) async {
    emit(LoginLoading());
    try {
      final String? identity = await getId();
      final response = await ApiManager().post(
          "http://165.22.201.156/api/app/auth/login?dial_code=+20&phone=${int.parse(phone.substring(1))}&identity=$identity");
      print("OTP: ${response["otp"]}");
      emit(LoginSuccess());
    } catch (e) {
      print(e.toString());
      emit(LoginFailure());
    }
  }
}
