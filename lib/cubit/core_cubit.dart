import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());

  static CoreCubit get(context) => BlocProvider.of(context);
  checkSignIN() async {
    final s = await SharedPreferences.getInstance();
    final token = s.getString("Token");
    emit(CoreSuccess(token: token));
  }
}
