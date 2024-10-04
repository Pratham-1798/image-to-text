import 'package:flutter/material.dart';
// import 'package:image_to_text_converter/homeScreen.dart';
import 'package:imagetotext/homeScreen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const homescreen()),
                );
              },
              child: Container(
                height: 144,
                width: 144,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(234, 238, 235, 1),
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                    "https://store-images.s-microsoft.com/image/apps.6245.13971189634504674.472023ad-3e0b-4229-82e4-f1e653ef2faf.bd77f319-9cc6-41ac-8a66-8c8492af562a"),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Text("Image-to-text converter"),
          ],
        ),
      ),
    );
  }
}
