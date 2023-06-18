import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_inventory_system/scanner/form_value.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class QrScanner extends StatefulWidget {
  const QrScanner({ Key? key }) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {

  Future<void> getDataFromBarcode(data)async{
    final response = await http.get(Uri.parse('$fetchQrCodeData$data'));
    final decoded = jsonDecode(response.body); 
    if(decoded.isNotEmpty){
      final product = decoded['stock'];
      final productName = product['name'] as String;
      final productID = product['id'].toString();
      final supplierName = product['supplier']['name'] as String;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'ID: $productID',
                  style: GoogleFonts.poppins(color: Colors.red, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  'Product: $productName',
                  style: GoogleFonts.poppins(color: Colors.red, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  'Supplier Name: $supplierName',
                  style: GoogleFonts.poppins(color: Colors.red, fontSize: 24),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormValue(
                            productName: productName,
                            productID: productID,
                            supplierName: supplierName,
                          ),
                        ),
                      );
                    },
                    child: const Text('Stock In'),
                  ),
                ),
              ],
            ),
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

  bool _screenOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Colors.white54,
      title: Text(
        'SCANNER',
        style: GoogleFonts.poppins(
          color: Colors.black,
        ),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 400),
            height: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 5),
            ),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
                torchEnabled: false,
              ),
              onDetect: (capture) {
                String? finalData;
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  setState(() {
                    String data = barcode.rawValue!;
                    finalData = data;
                  });
                }
                if (!_screenOpened) {
                  getDataFromBarcode(finalData);
                  _screenOpened = true;
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
  }
}