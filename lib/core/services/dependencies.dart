import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'initGetIt', preferRelativeImports: true, asExtension: true)
void configureDependencies() {
  getIt.initGetIt();
}

/// SDK singletons, injected so datasources never reach for globals.
@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}

@module
abstract class PlatformModule {
  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();

  @lazySingleton
  http.Client get httpClient => http.Client();

  /// Remembers the signed-in admin on this device (web: localStorage).
  @lazySingleton
  SharedPreferencesAsync get preferences => SharedPreferencesAsync();
}
