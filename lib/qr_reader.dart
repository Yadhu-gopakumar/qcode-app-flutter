import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:io';

class Qrreader extends StatefulWidget {
  const Qrreader({super.key});

  @override
  State<Qrreader> createState() => _QrreaderState();
}

class _QrreaderState extends State<Qrreader> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(children: <Widget>[
        mycameraView(context),
        Positioned(
          bottom: 20.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            (result != null)
                                ? 'Result : ${result?.code}'
                                : 'Scan code',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.tealAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        (result != null)
                            ? IconButton(
                                onPressed: () {
FlutterClipboard.copy('${result?.code}'.toString());
},
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.grey,
                                ),
                              )
                            : const SizedBox(
                                width: 20,
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget mycameraView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onqrviewcreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
          borderColor: Colors.tealAccent,
          borderWidth: 8,
          borderRadius: 13,
          borderLength: 30,
        ),
      );
  void onqrviewcreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
  super.dispose();
  }
}
