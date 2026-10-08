import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../../core/config/env.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/unified_api/error/failure.dart';

/// Uploads question images to ImgBB, the same way the seed tool does
/// (`tool/firebase/seed_firestore.dart`): base64 in an `image` form field,
/// no expiration; the URL is `data.image.url` (or `data.url`).
abstract class RemoteImageUploadDatasource {
  Future<String> uploadImage({required Uint8List bytes, required String name});
}

@Injectable(as: RemoteImageUploadDatasource)
class RemoteImageUploadDatasourceImpl implements RemoteImageUploadDatasource {
  RemoteImageUploadDatasourceImpl(this._client);

  final http.Client _client;

  @override
  Future<String> uploadImage({required Uint8List bytes, required String name}) async {
    if (!Env.hasImgbb) {
      throw const ServerFailure(message: 'questions.errors.noUploadKey');
    }
    final http.Response response;
    try {
      response = await _client
          .post(
            ApiEndpoints.imgbbUpload(Env.imgbbApiKey),
            body: {'name': name, 'image': base64Encode(bytes)},
          )
          .timeout(const Duration(seconds: 60));
    } on Exception {
      // Network errors and, on web, a CORS rejection both land here.
      throw const ServerFailure(message: 'questions.errors.uploadNetwork');
    }
    if (response.statusCode >= 400) {
      throw ServerFailure(
        message: 'questions.errors.uploadFailed',
        statusCode: response.statusCode,
      );
    }
    final decoded = jsonDecode(response.body);
    final data = decoded is Map<String, dynamic> ? decoded['data'] : null;
    final url = data is Map<String, dynamic>
        ? ((data['image'] as Map<String, dynamic>?)?['url'] ?? data['url'])
        : null;
    if (url is! String || url.isEmpty) {
      throw const ServerFailure(message: 'questions.errors.uploadFailed');
    }
    return url;
  }
}
