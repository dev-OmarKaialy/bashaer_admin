import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../models/picked_image_model.dart';

/// Gallery (Android) or file chooser (web). Android downsizes to 1600 px wide
/// at 85% quality, so students download small images.
abstract class LocalImagePickerDatasource {
  /// Null when the admin cancels.
  Future<PickedImageModel?> pickImage();
}

@Injectable(as: LocalImagePickerDatasource)
class LocalImagePickerDatasourceImpl implements LocalImagePickerDatasource {
  LocalImagePickerDatasourceImpl(this._picker);

  final ImagePicker _picker;

  @override
  Future<PickedImageModel?> pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return PickedImageModel(bytes: bytes, name: file.name);
  }
}
