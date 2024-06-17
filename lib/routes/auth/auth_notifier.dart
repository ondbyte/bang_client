import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/app_base/tried_and_catched.dart';
import 'package:bang_client/routes/auth/auth_provider.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_proto/auth_service.pb.dart';

class AuthNotifier extends BaseNotifier {
  @override
  BaseState build() {
    return NoState();
  }

  Future SendOtp(String phoneNumber) async {
    loading();
    Future.delayed(Duration(seconds: 5));
    final client = ref.watch(authServiceClientProvider);
    final tc =
        await tryCatch(client.sendOtp(SendOtpReq(phoneNumber: phoneNumber)));
    if (tc.err != null) {
      state = ErrorState(tc.err, tc.st);
      return;
    }
    state =
        OtpSentState(PhoneNumber: phoneNumber, OtpToken: tc.data.otpReqToken);
  }
}
