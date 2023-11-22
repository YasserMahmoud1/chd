import 'package:bloc/bloc.dart';
import 'package:chd/core/api_manager.dart';
import 'package:chd/features/home/Model/home_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  getData() async {
    emit(HomeLoading());

    try {
      final r =
          await ApiManager().get("http://165.22.201.156/api/app/account/me");
      if (r["data"]["accounts"][0]["active"]) {
        final result =
            await ApiManager().get("http://165.22.201.156/api/app/products");
        emit(HomeSuccess(
            products: result["data"]
                .map<HomeModel>((product) => HomeModel.fromJSON(product))
                .toList()));
      } else {
        throw ("Not Active");
      }
    } catch (e) {
      print(e.toString());
      emit(HomeFailure());
    }
  }
}
