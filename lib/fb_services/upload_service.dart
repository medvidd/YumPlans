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

  Future<void> deleteFile(String imageUrl) async {
    try {
      // 1. Перевіряємо, чи це посилання на Supabase (а не локальний асет)
      if (!imageUrl.startsWith('http')) return;

      // 2. Витягуємо шлях до файлу з URL
      // URL виглядає приблизно так:
      // .../storage/v1/object/public/images/recipes/userId/filename.jpg
      // Нам потрібно отримати: recipes/userId/filename.jpg

      // Розбиваємо URL по назві бакета
      final parts = imageUrl.split('images');
      if (parts.length < 2) return; // Невірний формат URL

      final filePath = parts.last;

      // 3. Видаляємо файл
      await _supabase.storage.from('images').remove([filePath]);
      print("File deleted from Supabase: $filePath");

    } catch (e) {
      print("Error deleting file from Supabase: $e");
      // Не кидаємо помилку далі, щоб не блокувати видалення самого рецепту
    }
  }
}