// uploading files to cloudinary
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:crypto/crypto.dart';
import 'package:np_career/api_key.dart';
import 'package:np_career/model/img_cloudinary.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'; // For accessing device directories

Future<ImgCloudinary?> uploadToCloudinary(
    FilePickerResult? filePickerResult) async {
  if (filePickerResult == null || filePickerResult.files.isEmpty) {
    print("No file selected!");
    return null;
  }

  final file = File(filePickerResult.files.single.path!);
  final cloudName = CLOUDINARY_CLOUD_NAME ?? '';

  final uri =
      Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/raw/upload");
  final request = http.MultipartRequest("POST", uri);

  final fileBytes = await file.readAsBytes();

  final multipartFile = http.MultipartFile.fromBytes(
    'file',
    fileBytes,
    filename: file.path.split("/").last,
  );

  request.files.add(multipartFile);
  request.fields['upload_preset'] = "npcareers";

  try {
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(responseBody);

      final uploadedFile = ImgCloudinary(
        name: filePickerResult.files.first.name,
        id: jsonResponse["public_id"],
        extension: filePickerResult.files.first.extension ?? '',
        size: jsonResponse["bytes"],
        url: jsonResponse["secure_url"],
        createdAt: jsonResponse["created_at"],
      );

      print("Upload successful!");
      return uploadedFile;
    } else {
      print("Upload failed with status: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Upload failed with error: $e");
    return null;
  }
}

// delete specific file from cloudinary
Future<bool> deleteFromCloudinary(String publicId) async {
  // Cloudinary details
  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ??
      ''; // Replace with your Cloudinary cloud name
  String apiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  String apiSecret = dotenv.env['CLOUDINARY_SECRET_KEY'] ?? '';

  // Generate the timestamp
  int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  // Prepare the string for signature generation
  String toSign = 'public_id=$publicId&timestamp=$timestamp$apiSecret';

  // Generate the signature using SHA1
  var bytes = utf8.encode(toSign);
  var digest = sha1.convert(bytes);
  String signature = digest.toString();
  // Prepare the request URL
  var uri =
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/raw/destroy/');

  // Create the request
  var response = await http.post(
    uri,
    body: {
      'public_id': publicId,
      'timestamp': timestamp.toString(),
      'api_key': apiKey,
      'signature': signature,
    },
  );

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['result'] == 'ok') {
      print("File deleted successfully.");
      return true;
    } else {
      print("Failed to delete the file.");
      return false;
    }
  } else {
    print(
        "Failed to delete the file, status: ${response.statusCode} : ${response.reasonPhrase}");
    return false;
  }
}

// download the user file inside the download folder
Future<bool> downloadFileFromCloudinary(String url, String fileName) async {
  try {
    // Request storage permission
    var status = await Permission.storage.request();
    var manageStatus = await Permission.manageExternalStorage.request();
    if (status == PermissionStatus.granted &&
        manageStatus == PermissionStatus.granted) {
      // The user has granted both permissions, so proceed
      print("Storage permissions granted");
    } else {
      // The user has permanently denied one or both permissions, so open the settings
      await openAppSettings();
    }

    // Get the Downloads directory
    Directory? downloadsDir = Directory('/storage/emulated/0/Download');
    if (!downloadsDir.existsSync()) {
      print("Downloads directory not found");
      return false;
    }

    // Create the file path
    String filePath = '${downloadsDir.path}/$fileName';

    // Make the HTTP GET request
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Write file to Downloads folder
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print("File downloaded successfully! Saved at: $filePath");
      return true;
    } else {
      print("Failed to download file. Status code: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("Error downloading file: $e");
    return false;
  }
}
