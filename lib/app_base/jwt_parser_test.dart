import 'package:bang_client/app_base/jwt_parser.dart';
import 'package:test/test.dart';

void main() {
  group('getClaimsFromJwt', () {
    test('should return claims for a valid JWT', () {
      // This is a simple JWT with payload {"sub": "1234567890", "name": "John Doe", "iat": 1516239022}
      const token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';

      final claims = getClaimsFromJwt(token);

      expect(claims, isNotEmpty);
      expect(claims['sub'], equals('1234567890'));
      expect(claims['name'], equals('John Doe'));
      expect(claims['iat'], equals(1516239022));
    });

    test('throw a format exception', () {
      const invalidToken = 'invalid.token';

      expect(() => getClaimsFromJwt(invalidToken), throwsFormatException);
    });
  });
}
