import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/tried_and_catched.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_proto/auth_service.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends BaseNotifier {
  @override
  BaseState build() {
    ref.listen(
      authNotifierProvider,
      (_, __) {
        loading(false);
      },
    );
    return NoState();
  }

  Future SendOtp(String phoneNumber) async {
    loading(true);
    final client = ref.watch(authServiceClientProvider);
    final tc =
        await tryCatch(client.sendOtp(SendOtpReq(phoneNumber: phoneNumber)));
    if (tc.err != null) {
      state = ErrorState(tc.err, tc.st);
      return;
    }
    state = OtpSentState(
      PhoneNumber: phoneNumber,
      OtpToken: tc.data.otpReqToken,
      validTill: tc.data.validTill,
    );
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, BaseState>(AuthNotifier.new);
