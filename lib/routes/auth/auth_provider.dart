import 'package:bang_client/app_base/base_notifier.dart';
import 'package:bang_client/config.dart';
import 'package:bang_client/routes/auth/auth_notifier.dart';
import 'package:bang_proto/auth_service.pbgrpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:grpc/grpc.dart';

final authServiceClientProvider = Provider<AuthServiceClient>((ref) {
  final config = ref.watch(configProvider);
  final channel = ClientChannel(
    config.AuthServiceHost,
    port: config.AuthServicePort,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    channelShutdownHandler: () {
      print("auth service channel was shut down");
    },
  );
  return AuthServiceClient(channel);
});

final authNotifierProvider =
    NotifierProvider<AuthNotifier, BaseState>(AuthNotifier.new);
