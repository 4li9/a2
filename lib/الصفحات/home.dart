import 'dart:typed_data';
import 'package:a2/%D9%82%D8%A7%D8%B9%D8%AF%D9%87%20%D8%A7%D9%84%D8%A8%D9%8A%D8%A7%D9%86%D8%A7%D8%AA/map.dart';
import 'package:a2/%D9%88%D8%AD%D8%AF%D9%87%20%D8%A7%D9%84%D8%AA%D8%AD%D9%83%D9%85/home_controller.dart';
import 'package:a2/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  homeControllerimp controller = Get.put(homeControllerimp());

  CameraController? _controller;
  FlutterTts flutterTts = FlutterTts();
  bool isProcessing = false;
  final textRecognizer = TextRecognizer();
  final Duration processingInterval = Duration(milliseconds: 500);
  DateTime? lastProcessedTime;
  String lastDetectedCurrency = "";
  String selectedCurrency = "الجنيه المصري"; // العملة المختارة افتراضيًا

  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      initializeCamera();
    } else {
      print("Camera permission denied");
    }
  }

  void initializeCamera() {
    _controller = CameraController(cameras![0], ResolutionPreset.high,
        enableAudio: false);
    _controller?.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      _controller?.startImageStream((CameraImage image) {
        if (!isProcessing && _canProcessImage()) {
          captureAndRecognizeText(image);
        }
      });
    });
  }

  bool _canProcessImage() {
    if (lastProcessedTime == null) return true;
    final now = DateTime.now();
    final elapsed = now.difference(lastProcessedTime!);
    return elapsed >= processingInterval;
  }

  void captureAndRecognizeText(CameraImage cameraImage) async {
    if (isProcessing) return;
    setState(() {
      isProcessing = true;
    });

    try {
      final InputImage inputImage = getInputImageFromCameraImage(cameraImage);
      final recognizedText = await textRecognizer.processImage(inputImage);

      String detectedCurrency = "";
      for (TextBlock block in recognizedText.blocks) {
        String text = block.text.trim();
        if (currencyDatabases[selectedCurrency]?.containsKey(text) ?? false) {
          detectedCurrency = currencyDatabases[selectedCurrency]![text]!;
          break;
        }
      }

      if (detectedCurrency.isNotEmpty &&
          detectedCurrency != lastDetectedCurrency) {
        await speak(detectedCurrency);
        lastDetectedCurrency = detectedCurrency;
      } else if (detectedCurrency.isEmpty &&
          lastDetectedCurrency != "Currency not recognized") {
        setState(() {
          lastDetectedCurrency = "Currency not recognized";
        });
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isProcessing = false;
      });
      lastProcessedTime = DateTime.now();
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  InputImage getInputImageFromCameraImage(CameraImage cameraImage) {
    return InputImage.fromBytes(
      bytes: concatenatePlanes(cameraImage.planes),
      inputImageData: InputImageData(
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        imageRotation: InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormat.nv21,
        planeData: cameraImage.planes.map((plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        }).toList(),
      ),
    );
  }

  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Reader'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // تعديل على حجم مربع الكاميرا إلى 200x200
          Container(
            width: 400,
            height: 500,
            child: _controller?.value.isInitialized == true
                ? CameraPreview(_controller!)
                : Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: 10),
          // زر اختيار العملة
          DropdownButton<String>(
            value: selectedCurrency,
            onChanged: (String? newValue) {
              setState(() {
                selectedCurrency = newValue!;
              });
            },
            items: currencyDatabases.keys
                .map<DropdownMenuItem<String>>((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // الزر الأول (الإعدادات) مع حواف منحنية
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // لون الخلفية الأسود
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // حواف منحنية
              ),
            ),
            onPressed: () {
              controller.goTosettinge();
            },
            child: Text(
              'الإعدادات',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          // الزر الثاني (الاشتراك) مع حواف منحنية
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // لون الخلفية الأسود
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // حواف منحنية
              ),
            ),
            onPressed: () {
              // إضافة عملية عند الضغط على زر الاشتراك
            },
            child: Text(
              'الاشتراك',
              style: TextStyle(color: Colors.white),
            ),
          ),
          if (lastDetectedCurrency == "Currency not recognized")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                lastDetectedCurrency,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
