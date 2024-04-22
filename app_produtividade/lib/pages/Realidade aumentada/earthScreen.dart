import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class PlanetaTerraScreen extends StatefulWidget {
  PlanetaTerraScreen({Key? key}) : super(key: key);

  @override
  _PlanetaTerraScreenState createState() => _PlanetaTerraScreenState();
}

class _PlanetaTerraScreenState extends State<PlanetaTerraScreen> {
  late ArCoreController arCoreController;

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _displayEarthMap();
  }

  Future<void> _displayEarthMap() async {
    final ByteData textureBytes = await rootBundle.load('assets/earth.jpg');

    final materials = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
      textureBytes: textureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(materials: [materials], radius: 0.1);

    final node = ArCoreNode(
      shape: sphere,
      position: Vector3(0, 0, -1.5),
    );

    arCoreController.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planeta Terra'),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Planeta Terra',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),



          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
            ),
          ),
        ],
      ),
    );
  }
}
