import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var qrCodeController = TextEditingController();
  var barcodeController = TextEditingController();
  Future<void> _scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'CANCEL', true, ScanMode.BARCODE);
      if (!mounted) return;
      if (barcode.isEmpty) {
        return;
      } else {
        setState(() => barcodeController.text = barcode);
      }
    } catch (e) {
      barcodeController.text = "Scan not Success!";
    }
  }

  Future<void> _scanQr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'CANCEL', true, ScanMode.QR);
      if (!mounted) return;
      if (qrCode.isEmpty) {
        return;
      } else {
        setState(() => qrCodeController.text = qrCode);
      }
    } catch (e) {
      qrCodeController.text = "Scan not Success!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My QR APP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildEmailFormField("QRCode", "input qrcode", qrCodeController),
            const SizedBox(
              height: 30,
            ),
            buildEmailFormField("Barcode", "inputBarcode", barcodeController),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildBotton(
                  "Scan QR",
                  () {
                    _scanQr();
                  },
                ),
                buildBotton(
                  "Scan Barcode",
                  () {
                    _scanBarcode();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBotton(String text, Function()? onTap) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }

  TextFormField buildEmailFormField(
      String title, String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: title,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: controller.text));
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Coped")));
            },
            icon: const Icon(Icons.content_copy),
          )),
    );
  }
}
