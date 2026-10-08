import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../firebase_options.dart';
import '../../extensions/log_colors_extension.dart';

/// Connects to Firebase project `bashaer-68ee6` and turns on the Firestore
/// offline cache on every platform (web too), so lists render from cache
/// right after a reload while the listeners catch up.
Future<void> initFirebase() async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  log('Firebase ready (${DefaultFirebaseOptions.currentPlatform.projectId})'.logWhite);
}
