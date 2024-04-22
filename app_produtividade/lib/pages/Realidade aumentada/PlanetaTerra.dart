import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ar_core/ar_core.dart';

List<CameraDescription> cameras = [];

void initCamera() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: ${e}');
  }
  final firstCamera = cameras.first;
  final cameraController = CameraController(
    firstCamera,
    ResolutionPreset.medium,
  );
  await cameraController.initialize();
}

class EarthScreen extends StatefulWidget {
  const EarthScreen({super.key});

  @override
  State<EarthScreen> createState() => _EarthScreenState();
}

class _EarthScreenState extends State<EarthScreen> {
  //late ARCoreController arCoreController;

  late CameraController cameraController;
  bool isStarted = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera();

    try {
      print(cameras);

      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } catch (e) {
      print("nao achou nenhuma camera");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planeta Terra'),
      ),
      body: Center(
        child: Augmented(
          'assets/earth.png', // Substitua pelo link da imagem ou caminho local
        ),
      ),
    );
  }
}
