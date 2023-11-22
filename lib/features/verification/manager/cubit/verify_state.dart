part of 'verify_cubit.dart';

@immutable
sealed class VerifyState {}

final class VerifyInitial extends VerifyState {}
final class VerifyLoading extends VerifyState {}
final class VerifySuccess extends VerifyState {}
final class VerifyFailure extends VerifyState {}
