import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Завантажує зображення у вказану папку (folder: 'avatars' або 'recipes')
  Future<String?> pickAndUploadImage({
    required String userId,
    required String folder,
  }) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Стиснення
        maxWidth: 1024,
      );

      if (image == null) return null;

      File file = File(image.path);
      String fileName = '$folder/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _supabase.storage.from('images').upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true),
      );

      final String publicUrl = _supabase
          .storage
          .from('images')
          .getPublicUrl(fileName);

      return publicUrl;

    } catch (e) {
      print("Upload Error: $e");
      return null;
    }
  }
}