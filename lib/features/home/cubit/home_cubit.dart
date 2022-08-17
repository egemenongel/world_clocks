import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/features/home/service/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _homeService;
  HomeCubit(this._homeService) : super(const HomeInital()) {
    fetchAreas();
  }

  bool isLoading = false;

  void loading() {
    isLoading = !isLoading;
    emit(HomeLoading(isLoading));
  }

  Future fetchAreas() async {
    loading();
    final response = await _homeService.fetchTimezoneAreas();
    loading();
    if (response is List) {
      emit(HomeLoaded(response));
    } else {
      emit(const HomeError());
    }
  }
}
