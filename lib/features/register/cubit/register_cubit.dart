import 'package:bloc/bloc.dart';
import 'package:chd/core/api_manager.dart';
import 'package:chd/core/function.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  register({
    required String fName,
    required String lName,
    required String phone,
  }) async {
    emit(RegisterLoading());
    try {
      final String? identity = await getId();
      final response = await ApiManager().post(
          "http://165.22.201.156/api/app/auth/register?dial_code=+20&first_name=$fName&last_name=$lName&type=individual&identity=$identity&phone=${int.parse(phone.substring(1))}");

      print(response);
      print("OTP: ${response["otp"]}");
      emit(RegisterSuccess());
    } catch (e) {
      print(e.toString());
      emit(RegisterFailure());
    }
  }
}
