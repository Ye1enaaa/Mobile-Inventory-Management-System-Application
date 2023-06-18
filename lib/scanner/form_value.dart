import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
class FormValue extends StatefulWidget {
final String productName;
final String productID;
final String supplierName;

const FormValue({ 
  Key? key,
  required this.supplierName,
  required this.productID,
  required this.productName 
}) : super(key: key);

  @override
  State<FormValue> createState() => _FormValueState();
}

class _FormValueState extends State<FormValue> {

  Future<void> stockIn()async{
    final id = prodIDcontrol.text;
    final name = nameControl.text;
    final supplierName = supplierNamecontrol.text;

    final body = {
      'stockName': name,
      'supplierName' : supplierName,
      'stockQuantity': int.parse(stockQuantitycontrol.text),
      'product_id' : int.parse(id),
    };
    final response = await http.post(
      Uri.parse(stockInRoute),
      body: jsonEncode(body),
      headers: {
        'Content-type' : 'application/json'
      }
    );
    //final data = jsonEncode(body);
    if(response.statusCode == 200){
      print('Success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock In Successful'))
      );
    }
    print(response.body);
  }
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController prodIDcontrol = TextEditingController();
  TextEditingController supplierNamecontrol = TextEditingController();
  TextEditingController stockQuantitycontrol = TextEditingController();
  @override
  Widget build(BuildContext context){
    String nameProduct = widget.productName;
    String productID = widget.productID;
    String supplierName = widget.supplierName;
    //int parsedQuantity = int.tryParse(quantityControl.text) ?? 0;
    //int parsedPrice = int.tryParse(priceProduct) ?? 0;
    nameControl.text = nameProduct;
    prodIDcontrol.text = productID;
    supplierNamecontrol.text = supplierName;
    return Scaffold(
    appBar: AppBar(
      title: const Text('Stock IN Form'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: nameControl,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
                enabled: false,
              ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: prodIDcontrol,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'ID NUMBER',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: supplierNamecontrol,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Supplier Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: stockQuantitycontrol,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: stockIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
  }
}