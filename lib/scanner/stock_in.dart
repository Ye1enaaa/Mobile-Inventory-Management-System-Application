import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class StockIn extends StatefulWidget {
  const StockIn({ Key? key }) : super(key: key);

  @override
  _StockInState createState() => _StockInState();
}

class _StockInState extends State<StockIn> {
  TextEditingController stockNameController = TextEditingController();
  TextEditingController stockPriceController = TextEditingController();
  TextEditingController stockQuantityController = TextEditingController();
  TextEditingController stockDescController = TextEditingController();
  bool _screenOpened = false;
  Future<void> postStockValue()async{
    final name  = stockNameController.text;
    final price = stockPriceController.text;
    final quantity = stockQuantityController.text;
    final desc = stockDescController.text;

    final body = {
      'name': name,
      'description':desc,
      'unit_price': price,
      'quantity': quantity 
    };
    final response = await http.post(
      Uri.parse(storeStocks),
      headers: {
        'Content-type':'application/json'
      },
      body: jsonEncode(body)
    );
    if(response.statusCode == 200){
      print('ok');
    }
  }
  Future<void> getDataValue(data)async{
    final response = await http.get(Uri.parse('https://api.upcitemdb.com/prod/trial/lookup?upc=$data'));
    final decode = jsonDecode(response.body) as Map;
    final decoded = decode['items'] as List;
    if(decoded.isNotEmpty){
      final stockValue = decoded.first as Map;
      final stockName = stockValue['title'];
      stockNameController.text = stockName;
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          content: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Product Name'
                  ),
                  controller: stockNameController),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Product price'
                  ),
                  controller: stockPriceController),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Product quantity'
                  ),
                  controller: stockQuantityController),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Product description'
                  ),
                  controller: stockDescController),
                ElevatedButton(onPressed: (){
                  postStockValue();
                }, child: const Text('STOCK IN'))
              ]
            ),
          ),
        );
      });
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock In'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  getDataValue(finalData);
                  _screenOpened = true;
                }
              }
            ),
          )
          ]
        ),
      ),
    );
  }
}