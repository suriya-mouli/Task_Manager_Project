import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerField extends StatelessWidget {
  const PhotoPickerField({
    super.key,
    required this.onTap,
    this.selectedPhoto,
  });

  final VoidCallback onTap;
  final XFile? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // leading thumbnail or icon (NOT PhotoPickerField again)
            const SizedBox(width: 12),
            _Thumb(selectedPhoto: selectedPhoto),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                selectedPhoto == null ? 'No Photo Selected' : selectedPhoto!.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.upload_file),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.selectedPhoto});
  final XFile? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    if (selectedPhoto == null) {
      return const Icon(Icons.photo_library_outlined);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.file(
        File(selectedPhoto!.path),
        height: 32,
        width: 32,
        fit: BoxFit.cover,
      ),
    );
  }
}
