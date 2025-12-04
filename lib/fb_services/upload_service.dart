import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UploadService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Відкриває галерею, завантажує фото в Supabase і повертає Public URL
  Future<String?> pickAndUploadImage(String userId) async {
    try {
      final ImagePicker picker = ImagePicker();
      // Зменшуємо якість (imageQuality: 70), щоб економити трафік і місце
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 1024,
      );

      if (image == null) return null;

      File file = File(image.path);
      // Генеруємо унікальне ім'я файлу, щоб уникнути кешування старих фото
      String fileName = 'users/$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Завантажуємо в бакет 'images' (переконайтеся, що він створений в Supabase)
      await _supabase.storage.from('images').upload(
        fileName,
        file,
        fileOptions: const FileOptions(upsert: true),
      );

      // Отримуємо публічне посилання
      final String publicUrl = _supabase
          .storage
          .from('images')
          .getPublicUrl(fileName);

      return publicUrl;

    } catch (e) {
      print("Upload Error: $e");
      // Тут можна кинути помилку далі, якщо потрібно показати її користувачу
      return null;
    }
  }
}