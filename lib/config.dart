import 'package:riverpod_annotation/riverpod_annotation.dart';

class Config {
  final String AuthServiceHost;
  final int AuthServicePort;
  final bool Debug;

  Config(
      {required this.AuthServiceHost,
      required this.AuthServicePort,
      required this.Debug});
}

final configProvider = Provider<Config>(
  (ref) {
    final env = String.fromEnvironment("ENV", defaultValue: "LOCAL");
    switch (env) {
      case "PROD":
        return ProdConfig();
      case "LOCAL":
        return LocalConfig();
      default:
        throw "config for $env isnt defined in the configProvider";
    }
  },
);

class LocalConfig extends Config {
  LocalConfig()
      : super(
          AuthServiceHost: "localhost",
          AuthServicePort: 8765,
          Debug: true,
        );
}

class ProdConfig extends Config {
  ProdConfig()
      : super(
          AuthServiceHost: "",
          AuthServicePort: 8765,
          Debug: true,
        ) {
    throw "prod config is not implemented";
  }
}
