import 'dart:async';

import 'package:bang_client/config.dart';
import 'package:bang_proto/auth_service.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:grpc/grpc.dart';

part 'auth_provider.g.dart';

enum AuthState { none, loading, success, err }

@Riverpod(keepAlive: true)
AuthServiceClient AuthServiceClientProvider(AuthServiceClientProviderRef ref) {
  final config = ref.watch(configProvider);
  final channel = ClientChannel(
    config.AuthServiceHost,
    port: config.AuthServicePort,
    channelShutdownHandler: () {
      print("auth service channel was shut down");
    },
  );
  return AuthServiceClient(channel);
}
