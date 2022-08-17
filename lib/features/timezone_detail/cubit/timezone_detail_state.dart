part of 'timezone_detail_cubit.dart';

abstract class TimezoneDetailState {
  const TimezoneDetailState();
}

class TimezoneDetailInital extends TimezoneDetailState {
  const TimezoneDetailInital();
}

class TimezoneDetailLoading extends TimezoneDetailState {
  final bool isLoading;

  const TimezoneDetailLoading(this.isLoading);
}

class TimezoneDetailLoaded extends TimezoneDetailState {
  final TimezoneModel response;
  const TimezoneDetailLoaded(this.response);
}

class TimezoneDetailError extends TimezoneDetailState {
  const TimezoneDetailError();
}
