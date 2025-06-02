// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart' as google_sign_in;
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:http/http.dart' as http;
// import 'package:np_career/utils/google_driver_picker.dart';

// class GoogleDriveHandler {
//   google_sign_in.GoogleSignInAccount? _account;

//   Future<String?> pickImageFromGoogleDrive(BuildContext context) async {
//     // 1. Đăng nhập Google
//     final googleSignIn = google_sign_in.GoogleSignIn(
//       scopes: [drive.DriveApi.driveReadonlyScope],
//     );
//     _account = await googleSignIn.signIn();
//     if (_account == null) {
//       // Người dùng hủy đăng nhập
//       return null;
//     }

//     // 2. Lấy auth headers
//     final authHeaders = await _account!.authHeaders;
//     final authClient = _GoogleAuthClient(authHeaders);

//     // 3. Tạo API Drive
//     final driveApi = drive.DriveApi(authClient);

//     // 4. Lấy danh sách file ảnh (có thể lấy nhiều file hoặc chỉ 1)
//     final fileList = await driveApi.files.list(
//       q: "mimeType contains 'image/' and trashed = false",
//       spaces: 'drive',
//       $fields: 'files(id, name, webViewLink, thumbnailLink, mimeType)',
//       pageSize: 50,
//     );

//     // 5. Mở màn hình chọn ảnh, truyền fileList qua
//     final selectedLink = await Navigator.push<String>(
//       context,
//       MaterialPageRoute(
//         builder: (context) => GoogleDriveFilePickerScreen(fileList: fileList),
//       ),
//     );

//     // 6. Đóng client
//     authClient.close();

//     return selectedLink; // link ảnh hoặc null nếu ko chọn
//   }
// }

// class _GoogleAuthClient extends http.BaseClient {
//   final Map<String, String> _headers;
//   final http.Client _client = http.Client();

//   _GoogleAuthClient(this._headers);

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) {
//     request.headers.addAll(_headers);
//     return _client.send(request);
//   }

//   void close() {
//     _client.close();
//   }
// }
