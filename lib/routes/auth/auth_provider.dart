import 'dart:async';

import 'package:bang_client/app_base/tried_and_catched.dart';
import 'package:bang_client/config.dart';
import 'package:bang_client/routes/auth/states.dart';
import 'package:bang_proto/auth_service.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:grpc/grpc.dart';

final authServiceClientProvider = Provider<AuthServiceClient>((ref) {
  final config = ref.watch(configProvider);
  final channel = ClientChannel(
    config.AuthServiceHost,
    port: config.AuthServicePort,
    channelShutdownHandler: () {
      print("auth service channel was shut down");
    },
  );
  return AuthServiceClient(channel);
});

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return NoneState();
  }

  Future SendOtp(String phoneNumber) async {
    final client = ref.watch(authServiceClientProvider);
    try {
      client.sendOtp(SendOtpReq(phoneNumber: phoneNumber));
    } catch (err) {
      print(err);
      state = ErrorState(err);
      return;
    }
  }
}

final authNotifierProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
