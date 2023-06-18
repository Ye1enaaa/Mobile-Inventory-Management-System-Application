import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
class ReturnDamageForm extends StatefulWidget {
final String productName;
final String productID;
final String supplierName;

const ReturnDamageForm({ 
  Key? key,
  required this.supplierName,
  required this.productID,
  required this.productName 
}) : super(key: key);

  @override
  State<ReturnDamageForm> createState() => _ReturnDamageFormState();
}

class _ReturnDamageFormState extends State<ReturnDamageForm> {

  Future<void> returnByDamage()async{
    final id = prodIDcontrol.text;
    final name = nameControl.text;
    final customerName = customerNamecontrol.text;
    const comments = 'RETURN DUE TO DAMAGE';

    final body = {
      'stockName': name,
      'customerName' : customerName,
      'stockQuantityReturn': int.parse(stockQuantitycontrol.text),
      'product_id' : int.parse(id),
      'comments': comments
    };
    final response = await http.post(
      Uri.parse(returnDamageStockRoute),
      body: jsonEncode(body),
      headers: {
        'Content-type' : 'application/json'
      }
    );
    //final data = jsonEncode(body);
    if(response.statusCode == 200){
      print('Success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Return Log Successful'))
      );
    }
    print(response.body);
  }
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController prodIDcontrol = TextEditingController();
  TextEditingController supplierNamecontrol = TextEditingController();
  TextEditingController stockQuantitycontrol = TextEditingController();
  TextEditingController customerNamecontrol = TextEditingController();
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
        //automaticallyImplyLeading: false,
        title: const Text('Return due to damage form'),
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
            keyboardType: TextInputType.number,
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
              returnByDamage();
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