part of 'core_cubit.dart';

@immutable
sealed class CoreState {}

final class CoreInitial extends CoreState {}

// ignore: must_be_immutable
final class CoreSuccess extends CoreState {
  String? token;

  CoreSuccess({required this.token});
}
