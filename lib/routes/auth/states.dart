class AuthState {
  final String PhoneNumber;
  final String OtpToken;
  final String AccessToken;
  final String SessionToken;
  final bool loading;

  AuthState({
    this.PhoneNumber = "",
    this.OtpToken = "",
    this.AccessToken = "",
    this.SessionToken = "",
    this.loading = false,
  });
}

class ErrorState extends AuthState {
  final Object? err;
  ErrorState(this.err) : super();
}

class NoneState extends AuthState {
  NoneState() : super();
}

class LoadingState extends AuthState {
  LoadingState() : super(loading: true);
}

class PhoneNumberEnteredState extends AuthState {
  PhoneNumberEnteredState({required PhoneNumber})
      : super(PhoneNumber: PhoneNumber);
}

class OtpSentState extends AuthState {
  OtpSentState({required PhoneNumber, required OtpToken})
      : super(PhoneNumber: PhoneNumber, OtpToken: OtpToken);
}

class OtpVerifiedHasAccessTokenState extends AuthState {
  OtpVerifiedHasAccessTokenState({required PhoneNumber, required AccessToken})
      : super(PhoneNumber: PhoneNumber, AccessToken: AccessToken);
}

class SessionTokenState extends AuthState {
  SessionTokenState(
      {required PhoneNumber, required AccessToken, required SessionToken})
      : super(
            PhoneNumber: PhoneNumber,
            AccessToken: AccessToken,
            SessionToken: SessionToken);
}
