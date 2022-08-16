part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInital extends HomeState {
  const HomeInital();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {}
