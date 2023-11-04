import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:project1/pages/home.dart';

class MlScreen extends ConsumerStatefulWidget {
  final aadhar;
  const MlScreen({super.key, this.aadhar});

  @override
  ConsumerState<MlScreen> createState() => _MlScreenState();
}

class _MlScreenState extends ConsumerState<MlScreen> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF5F9FF),
        title: Text(
          'Facial Verification',
          style: TextStyle(
              fontFamily: "Jost",
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              'Face taken with referenced to Aadhar Card ',
              style: TextStyle(color: Color(0xff545454), fontFamily: 'Jost'),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset('assets/img.png'),
          SizedBox(
            height: 20,
          ),
          TextButton(
            style: ButtonStyle(),
            onPressed: () async {
              final XFile? imagecamera =
                  await picker.pickImage(source: ImageSource.camera);
              String path = imagecamera!.path;
              print(path);
              String res = await sendImage(
                  "https://9014-210-212-97-172.ngrok-free.app", path);
              if (res == "Success") {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              }
              //final ImagePicker picker = ImagePicker();
              //final LostDataResponse response = await picker.pickImage(source: );
            },
            child: Text(
              'Face the Camera',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> sendImage(apiUrl, String imagePath) async {
    var postUri = Uri.parse(apiUrl);

    http.MultipartRequest request = new http.MultipartRequest("POST", postUri);

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image1', imagePath);
    request.fields['aadhar_no'] = widget.aadhar.toString();
    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    var responsed = await http.Response.fromStream(response);
    var result = jsonDecode(responsed.body) as Map<String, dynamic>;
    final results = json.decode(responsed.toString())['result'];

    print(responsed.body);
    print(results);
    return "Success";
  }
}
