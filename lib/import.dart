import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Import extends ConsumerWidget {
  const Import({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import')),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['csv']);

                if (result != null) {
                  File file = File(result.files.single.path ?? '');
                  print(file.path);
                }
              },
              child: const Text('Import'))),
    );
  }
}
