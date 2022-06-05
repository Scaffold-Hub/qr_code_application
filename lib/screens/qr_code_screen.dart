import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  late Barcode result;
  late QRViewController qrViewController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isOpenFlash = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildQrView(),
          _buildSheet(),
        ],
      ),
    );
  }

  Widget _buildSheet() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpenFlash = !isOpenFlash;
                    });
                    qrViewController.toggleFlash();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isOpenFlash ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      isOpenFlash ? Icons.flash_off : Icons.flash_on,
                      color: Colors.grey.shade200,
                      size: 40,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    qrViewController.flipCamera();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      Icons.flip_camera_android_outlined,
                      color: Colors.grey.shade200,
                      size: 40,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView() {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    return Expanded(
      flex: 3,
      child: Container(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQrViewCreated,
          cameraFacing: CameraFacing.front,
          formatsAllowed: const [BarcodeFormat.qrcode],
          overlay: QrScannerOverlayShape(
            borderColor: Colors.black,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
        ),
      ),
    );
  }

  void _onQrViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });
    qrViewController.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
