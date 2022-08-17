import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_clocks/features/timezone_detail/model/timezone_model.dart';
import 'package:world_clocks/features/timezone_detail/service/timezone_service.dart';

part 'timezone_detail_state.dart';

class TimezoneDetailCubit extends Cubit<TimezoneDetailState> {
  final TimezoneService _timezoneService;
  TimezoneDetailCubit(this._timezoneService)
      : super(const TimezoneDetailInital());
  bool isLoading = false;
  void loading() {
    isLoading = !isLoading;
    emit(TimezoneDetailLoading(isLoading));
  }

  Future<void> fetchTimezone(String timezone) async {
    loading();
    final TimezoneModel? response =
        await _timezoneService.fetchTimezone(timezone);
    loading();
    if (response is TimezoneModel) {
      emit(TimezoneDetailLoaded(response));
    } else {
      emit(const TimezoneDetailError());
    }
  }
}
