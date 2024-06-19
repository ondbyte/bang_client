import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_proto/google/protobuf/timestamp.pb.dart';

class AuthState extends BaseState {
  AuthState();
}

class ErrorState extends AuthState {
  final Object? err;
  final StackTrace? st;
  ErrorState(this.err, this.st) : super();
}

class PhoneNumberEnteredState extends AuthState {
  final String PhoneNumber;
  PhoneNumberEnteredState({required this.PhoneNumber}) : super();
}

class OtpSentState extends PhoneNumberEnteredState {
  final String OtpToken;
  final Timestamp validTill;
  OtpSentState({
    required super.PhoneNumber,
    required this.OtpToken,
    required this.validTill,
  }) : super();
}

class OtpVerifiedHasAccessTokenState extends PhoneNumberEnteredState {
  final String AccessToken;
  OtpVerifiedHasAccessTokenState(
      {required super.PhoneNumber, required this.AccessToken})
      : super();
}

class SessionTokenState extends OtpVerifiedHasAccessTokenState {
  SessionTokenState(
      {required super.PhoneNumber,
      required super.AccessToken,
      required SessionToken})
      : super();
}
