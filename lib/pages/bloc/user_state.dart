part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

final class UserEror extends UserState {
  final String error;
  UserEror(this.error);
}
