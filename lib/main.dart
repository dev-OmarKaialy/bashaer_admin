import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/services/dependencies.dart';
import 'core/services/firebase/firebase_config.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

/// Bootstrapping order:
/// 1) framework bindings and translations (Arabic only)
/// 2) Firebase + Firestore offline cache
/// 3) dependency injection, then the app
///
/// Nothing else is awaited before the first frame: the auth gate shows the
/// splash while the remembered session is checked.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait<void>([EasyLocalization.ensureInitialized(), initFirebase()]);
  configureDependencies();
  // The splash shows while the remembered session is checked.
  unawaited(getIt<AuthCubit>().restore());

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar')],
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      saveLocale: false,
      child: const AdminApp(),
    ),
  );
}
