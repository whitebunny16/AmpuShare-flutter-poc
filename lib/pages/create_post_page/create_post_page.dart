import 'dart:io';

import 'package:ampushare/services/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreatePostPage extends HookWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final captionController = useTextEditingController();
    final mediaFile = useState<File?>(null);

    Future<void> _createPost(String caption, File? mediaFile) async {
      if (caption.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Caption is required')),
        );
        return;
      }

      var dio = await DioHelper.getDio();
      FormData formData = FormData.fromMap({
        'caption': caption,
        if (mediaFile != null)
          mediaFile.path.endsWith('.mp4') ? 'video' : 'image':
              await MultipartFile.fromFile(mediaFile.path),
      });

      final response = await dio.post(
        '/api/social/posts',
        data: formData,
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to create post');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: captionController,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Caption',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'png', 'mp4'],
                );

                if (result != null) {
                  mediaFile.value = File(result.files.single.path!);
                }
              },
              child: const Text('Pick Media'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _createPost(captionController.text, mediaFile.value),
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}
