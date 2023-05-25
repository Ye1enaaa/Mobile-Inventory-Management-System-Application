import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/constants/constants.dart';
class StockOutForm extends StatefulWidget {
final String productName;
final String productID;


const StockOutForm({ 
  Key? key,
  required this.productID,
  required this.productName 
}) : super(key: key);

  @override
  State<StockOutForm> createState() => _StockOutFormState();
}

class _StockOutFormState extends State<StockOutForm> {

  Future<void> stockOut()async{
    final id = prodIDcontrol.text;
    final name = nameControl.text;
    final supplierName = customerNamecontrol.text;

    final body = {
      'stockName': name,
      'supplierName' : supplierName,
      'stockQuantity': int.parse(stockQuantitycontrol.text),
      'product_id' : int.parse(id),
    };
    final response = await http.post(
      Uri.parse(stockOutRoute),
      body: jsonEncode(body),
      headers: {
        'Content-type' : 'application/json'
      }
    );
    //final data = jsonEncode(body);
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock Out Successful'))
      );
    }
    print(response.body);
  }
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController prodIDcontrol = TextEditingController();
  TextEditingController customerNamecontrol = TextEditingController();
  TextEditingController stockQuantitycontrol = TextEditingController();
  @override
  Widget build(BuildContext context){
    String nameProduct = widget.productName;
    String productID = widget.productID;  
    //int parsedQuantity = int.tryParse(quantityControl.text) ?? 0;
    //int parsedPrice = int.tryParse(priceProduct) ?? 0;
    nameControl.text = nameProduct;
    prodIDcontrol.text = productID;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Stock IN Form'),
      ), 
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: nameControl,
              decoration: const InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
              enabled: false
            ),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: prodIDcontrol,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'ID NUMBER',
              border: OutlineInputBorder(),
              //hintText: quantityProduct,
            ),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: customerNamecontrol,
            decoration: const InputDecoration(
              labelText: 'Customer Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: stockQuantitycontrol,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12.0),
          // ElevatedButton(
          //   onPressed: (){
          //     //int totalValue = parsedQuantity * parsedPrice;
          //     //print(parsedQuantity);
          //    // print(parsedPrice);
          //     //print(totalValue);
          //     //totalControl.text = totalValue.toString();
          //     setState(() {});
          //   },
          //   child: const Text('Calculate Total'),
          //   style: ElevatedButton.styleFrom(
          //     primary: Colors.blue,
          //     onPrimary: Colors.white,
          //   ),
          // ),
          // SizedBox(height: 12.0),
          // TextFormField(
          //   controller: totalControl,
          //   decoration: InputDecoration(
          //     labelText: 'Total',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 12.0),
          ElevatedButton(
            onPressed: (){
              stockOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
          ],
        )
      ),
    );
  }
}