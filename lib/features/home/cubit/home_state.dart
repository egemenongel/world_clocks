part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInital extends HomeState {
  const HomeInital();
}

class HomeLoading extends HomeState {
  final bool isLoading;
  const HomeLoading(this.isLoading);
}

class HomeLoaded extends HomeState {
  final List<dynamic> response;
  const HomeLoaded(this.response);
}

class HomeError extends HomeState {
  const HomeError();
}
