import 'dart:typed_data';

/// Image bytes picked from the gallery or files. Bytes (not a `File`) so the
/// same code runs on Android and web.
class PickedImageModel {
  const PickedImageModel({required this.bytes, required this.name});

  final Uint8List bytes;
  final String name;
}
