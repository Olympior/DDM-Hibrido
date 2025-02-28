import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../services/api_service.dart';

class TelaEscaneamento extends StatefulWidget {
  const TelaEscaneamento({super.key});

  @override
  State<TelaEscaneamento> createState() => _TelaEscaneamentoState();
}

class _TelaEscaneamentoState extends State<TelaEscaneamento> {
  late MobileScannerController cameraController;
  bool isLoading = false;
  bool torchEnabled = false;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Produto'),
        actions: [
          IconButton(
            icon: Icon(torchEnabled ? Icons.flash_on : Icons.flash_off),
            onPressed: () => setState(() => torchEnabled = !torchEnabled),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) async {
              if (isLoading) return;

              final barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;

              setState(() => isLoading = true);

              try {
                final productData = await ApiService.getProduct(barcodes.first.rawValue!);
                if (mounted) {
                  Navigator.pop(context, productData);
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              } finally {
                setState(() => isLoading = false);
              }
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}