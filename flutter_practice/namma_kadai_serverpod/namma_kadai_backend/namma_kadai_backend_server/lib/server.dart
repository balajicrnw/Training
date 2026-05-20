import 'dart:io';

import 'package:namma_kadai_backend_server/src/web/routes/cors_route.dart';
import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart' hide Protocol;
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/firestore_api_route.dart';
import 'src/web/routes/root.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // ROOT ROUTES
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  // =========================
  // CORS FIX
  // =========================

  // CORS preflight handler

  // =========================
  // FIRESTORE ROUTES
  // =========================

  final firestoreRoute = FirestoreApiRoute();

  pod.webServer.addRoute(firestoreRoute, '/seedProducts');
  pod.webServer.addRoute(firestoreRoute, '/createProduct');
  pod.webServer.addRoute(firestoreRoute, '/updateProduct');
  pod.webServer.addRoute(firestoreRoute, '/deleteProduct');
  pod.webServer.addRoute(firestoreRoute, '/updateCartQuantity');
  pod.webServer.addRoute(firestoreRoute, '/removeFromCart');
  pod.webServer.addRoute(firestoreRoute, '/clearCart');
  pod.webServer.addRoute(firestoreRoute, '/getProducts');
  pod.webServer.addRoute(firestoreRoute, '/getUserData');
  pod.webServer.addRoute(firestoreRoute, '/getCartItems');
  pod.webServer.addRoute(firestoreRoute, '/getOrders');
  pod.webServer.addRoute(firestoreRoute, '/saveUserData');
  pod.webServer.addRoute(firestoreRoute, '/saveOrder');
  pod.webServer.addRoute(firestoreRoute, '/addToCart');

  // AUTH ROUTES
  pod.webServer.addRoute(firestoreRoute, '/auth/signIn');
  pod.webServer.addRoute(firestoreRoute, '/auth/signUp');
  pod.webServer.addRoute(firestoreRoute, '/auth/signOut');

  // STATIC FILES
  final root = Directory(
    Uri(path: 'web/static').toFilePath(),
  );

  pod.webServer.addRoute(
    StaticRoute.directory(root),
  );

  // APP CONFIG
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  // FLUTTER WEB
  final appDir = Directory(
    Uri(path: 'web/app').toFilePath(),
  );

  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(appDir),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(
          Uri(
            path: 'web/pages/build_flutter_app.html',
          ).toFilePath(),
        ),
      ),
      '/app/**',
    );
  }

  await pod.start();
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log(
    '[EmailIdp] Registration code ($email): $verificationCode',
  );
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  session.log(
    '[EmailIdp] Password reset code ($email): $verificationCode',
  );
}
