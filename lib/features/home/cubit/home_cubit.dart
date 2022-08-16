import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/features/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService;
  HomeCubit(this._homeService) : super(const HomeLoading()) {
    fetchAreas();
  }

  Future fetchAreas() async {
    emit(const HomeLoading());
    var response = await _homeService.fetchTimezoneAreas();
    emit(HomeLoaded(response!));
  }
}
