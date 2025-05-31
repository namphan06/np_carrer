import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;

class GoogleDriveFilePickerScreen extends StatelessWidget {
  final drive.FileList fileList;
  const GoogleDriveFilePickerScreen({Key? key, required this.fileList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final files = fileList.files ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Chọn ảnh từ Google Drive')),
      body: files.isEmpty
          ? Center(child: Text('Không tìm thấy ảnh trên Google Drive'))
          : ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                if (file.mimeType != null &&
                    file.mimeType!.startsWith('image/')) {
                  return ListTile(
                    leading: file.thumbnailLink != null
                        ? Image.network(file.thumbnailLink!)
                        : Icon(Icons.image),
                    title: Text(file.name ?? 'Không tên'),
                    onTap: () {
                      Navigator.pop(context, file.webViewLink ?? '');
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
    );
  }
}
