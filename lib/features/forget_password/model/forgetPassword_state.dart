class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class ForgetPasswordLoading extends ForgetPasswordState {}
final class ForgetPasswordSuccess extends ForgetPasswordState {
  String message;
  ForgetPasswordSuccess({required this.message});
}
final class ForgetPasswordFailed extends ForgetPasswordState {
  String error;
  ForgetPasswordFailed({required this.error});
}
