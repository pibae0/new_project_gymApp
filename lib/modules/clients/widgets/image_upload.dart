import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

uploadImage(String image, File file) async {
  var request = http.MultipartRequest("POST", Uri.parse(""));

  request.fields[' image '] = 'imageName';
  request.headers['Authorization'] = '';

  var picture = http.MultipartFile.fromBytes(
      'image', (await rootBundle.load('assets/image')).buffer.asUint8List(),
      filename: '');

  request.files.add(picture);

  var response = await request.send();

  var responseData = await response.stream.toBytes();

  var result = String.fromCharCodes(responseData);

  print(result);
}
