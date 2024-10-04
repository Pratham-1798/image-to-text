import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:clay_containers/clay_containers.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  XFile? pickedImage;
  String myText = '';
  bool scanning = false;

  final ImagePicker _imagePicker = ImagePicker();

  getImage(ImageSource ourSource) async {
    XFile? result = await _imagePicker.pickImage(source: ourSource);

    if (result != null) {
      setState(() {
        pickedImage = result;
      });

      performTextRecognition();
    }
  }

  performTextRecognition() async {
    setState(() {
      scanning = true;
    });
    try {
      final inputImage = InputImage.fromFilePath(pickedImage!.path);

      final TextRecognizer = GoogleMlKit.vision.textRecognizer();

      final recognizedText = await TextRecognizer.processImage(inputImage);

      setState(() {
        myText = recognizedText.text;
        scanning = false;
      });

      TextRecognizer.close();
    } catch (e) {
      print("Error during text recognition : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Recognition App"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          pickedImage == null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ClayContainer(
                    height: 400,
                    child: Center(
                      child: Text("No Image Selected"),
                    ),
                  ),
                )
              : Center(
                  child: Image.file(
                    File(pickedImage!.path),
                    height: 400,
                  ),
                ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.photo),
                label: Text("Gallery"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Camera"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: Text("Recognised Text"),
          ),
          SizedBox(height: 30),
          scanning
              ? Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: Colors.black,
                      size: 50.0,
                    ),
                  ),
                )
              : Center(
                  child: AnimatedTextKit(animatedTexts: [
                    TypewriterAnimatedText(myText,
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: Duration(milliseconds: 100))
                  ]),
                ),
        ],
      ),
    );
  }
}
