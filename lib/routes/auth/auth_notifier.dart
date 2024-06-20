import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/jwt_parser.dart';
import 'package:bang_client/app_base/tried_and_catched.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/err_state.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_proto/auth_service.pb.dart';
import 'package:bang_proto/google/protobuf/timestamp.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

class AuthNotifier extends BaseNotifier {
  @override
  BaseState build() {
    ref.listen(
      authNotifierProvider,
      (_, currState) {
        loading(false);
        if(cur)
      },
    );
    return NoState();
  }

  Future SendOtp(String phoneNumber) async {
    try {
      loading(true);
      final client = ref.watch(authServiceClientProvider);
      final resp = await client.sendOtp(SendOtpReq(phoneNumber: phoneNumber));
      final claims = getClaimsFromJwt(resp.otpReqToken);
      final expiry = claims["expiry"];
      state = OtpSentState(
        PhoneNumber: phoneNumber,
        OtpToken: resp.otpReqToken,
        validTill: expiry,
      );
    } catch (e, st) {
      state = ErrorState(e, st);
    }
  }

  Future verifyOtp(String phoneNumber, String otp, String otpToken) async {
    try {
      loading(true);
      final client = ref.watch(authServiceClientProvider);
      final resp = await client.verifyOtp(
        VerifyOtpReq(
          otp: otp,
          otpReqToken: otpToken,
        ),
      );
      state = OtpVerifiedHasAccessTokenState(
        AccessToken: resp.accessToken,
      );
    } catch (e, st) {
      state = ErrorState(e, st);
    }
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, BaseState>(AuthNotifier.new);
