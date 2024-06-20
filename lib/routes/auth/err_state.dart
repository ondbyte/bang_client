import 'package:bang_client/routes/auth/states.dart';
import 'package:grpc/grpc.dart';

class ErrorState extends AuthState {
  final Object? err;
  final StackTrace? st;
  ErrorState(this.err, this.st) : super();

  String getUserPresentableErr() {
    switch (Object) {
      case GrpcError err:
        print("GrpcError: $err");
        return "seems like some connection issues";
      case FormatException err:
        print("FormatException: $err");
        return "seems like some data exchange issues";
      default:
        print("Weierd issue: $err");
        return "seems like some weierd issues";
    }
  }
}
