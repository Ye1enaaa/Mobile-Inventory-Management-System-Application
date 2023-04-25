import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class QrScanner extends StatefulWidget {
  const QrScanner({ Key? key }) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  Future<void> getDataFromBarcode(data)async{
    final response = await http.get(Uri.parse('$getDataFromBarcodeUrl$data'));
    final decode = jsonDecode(response.body) as Map;
    final decoded = decode['product'] as List;
    if(decoded.isNotEmpty){
      final product = decoded.first as Map;
      final productName = product['name'] as String;
      final productPrice = product['unit_price'] as String;
      final productDesc = product['description'] as String;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: 200,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(productName, style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text(productPrice, style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text(productDesc, style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
              ],
            ),
          ),
        );
      });
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: Column(
        children: [
        const SizedBox(height: 220),
        Container(
          height: 300,
          child: MobileScanner(     
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: false
            ),
            onDetect: (capture){
              String? finalData;
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for(final barcode in barcodes){
                setState(() {
                  String data = barcode.rawValue!;
                  finalData = data;
                  //debugPrint(data);
                });
              }
              getDataFromBarcode(finalData);
            }
          ),
        )
        ]
      ),
    );
  }
}