import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_inventory_system/returnByexchange/return_exchange_form.dart';
import 'package:mobile_inventory_system/returns/return_damage_form.dart';
import 'package:mobile_inventory_system/scanner/form_value.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class ReturnExchangeScan extends StatefulWidget {
  const ReturnExchangeScan({ Key? key }) : super(key: key);

  @override
  _ReturnExchangeScanState createState() => _ReturnExchangeScanState();
}

class _ReturnExchangeScanState extends State<ReturnExchangeScan> {

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
          content: Container(
            height: 250,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text('ID: $productID', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text('Product: $productName', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 20),
                Text('Supplier Name: $supplierName', style:GoogleFonts.poppins(color: Colors.red, fontSize: 24)),
                const SizedBox(height: 1),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ReturnExchangeForm(
                    productName: productName, 
                    productID: productID,
                    supplierName: supplierName,
                  )));
                }, child: const Text('Return Stock'))
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