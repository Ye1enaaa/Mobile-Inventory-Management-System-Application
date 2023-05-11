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
    final response = await http.get(Uri.parse('$getDataFromBarcodeUrl$data'));
    final decode = jsonDecode(response.body) as Map;
    final decoded = decode['product'] as List;
    if(decoded.isNotEmpty){
      final product = decoded.first as Map;
      final productName = product['name'] as String;
      final productPrice = product['unit_price'] as String;
      final productQuantity = product['quantity'] as String;
      final productDesc = product['description'] as String;
      final productTotalValue = product['inventory_value'] as String;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: 500,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('Product: $productName', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text('Price: $productPrice', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text('Quantity: $productQuantity', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 1),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FormValue(
                    productName: productName, 
                    productQuantity: productQuantity,
                    productPrice: productPrice,
                  )));
                }, child: const Text('Place Order'))
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

  bool _screenOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white54,
        title: Text('SCANNER', style: GoogleFonts.poppins(
          color: Colors.black
        )),
      ),
      body: Column(
        children: [
        const SizedBox(height: 220),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 5
            )
          ),
          child: MobileScanner(     
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: false
            ),
            onDetect: (capture){
              String? finalData;
              /*Barcode barcode;
              setState(() {
                final String data = barcode.rawValue ?? '';
                finalData = data;
              });*/
              final List<Barcode> barcodes = capture.barcodes;
              //final Uint8List? image = capture.image;
              for(final barcode in barcodes){
                setState(() {
                  String data = barcode.rawValue!;
                  finalData = data;
                  //debugPrint(data);
                });
              }
              if(!_screenOpened){
                getDataFromBarcode(finalData);
                _screenOpened = true;
              }
            }
          ),
        )
        ]
      ),
    );
  }
}