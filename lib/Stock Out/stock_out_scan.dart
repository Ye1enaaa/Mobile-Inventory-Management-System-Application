import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_inventory_system/Stock%20Out/stock_out_form.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../constants/constants.dart';

class StockOutScan extends StatefulWidget {
  const StockOutScan({ Key? key }) : super(key: key);

  @override
  _StockOutScanState createState() => _StockOutScanState();
}

class _StockOutScanState extends State<StockOutScan> {
  Future<void> getDataFromBarcode(data)async{
    final response = await http.get(Uri.parse('$fetchQrCodeData$data'));
    final decoded = jsonDecode(response.body); 
    if(decoded.isNotEmpty){
      final product = decoded['stock'];
      final productName = product['name'] as String;
      final productID = product['id'].toString();
      final productPrice = product['unit_price'].toString();
      final productQuantity = product['quantity'].toString();
      final supplierName = product['supplier']['name'] as String;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Text('ID: $productID', style: GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                  const SizedBox(height: 20),
                  Text('Product: $productName', style: GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                  const SizedBox(height: 20),
                  Text('Supplier Name: $supplierName', style: GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                  const SizedBox(height: 20),
                  Text('Price: $productPrice', style: GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                  const SizedBox(height: 20),
                  Text('Stock on Hand: $productQuantity', style: GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StockOutForm(
                          productName: productName,
                          productID: productID,
                          productQuantity: productQuantity,
                        )),
                      );
                    },
                    child: const Text('Stock Out'),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }
  }
  bool _screenOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
            Expanded(
              child: Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}