import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
class FormValue extends StatefulWidget {
final String productName;
final String productQuantity;
final String productPrice;

FormValue({ 
  Key? key,
  required this.productPrice,
  required this.productQuantity,
  required this.productName 
}) : super(key: key);

  @override
  State<FormValue> createState() => _FormValueState();
}

class _FormValueState extends State<FormValue> {

  Future<void> postDataFromStaff()async{
    final name = nameControl.text;
    final quantity = quantityControl.text;
    //final unit_price = priceControl.text;
    final total_value = totalControl.text;

    final body = {
      'name_value': name,
      'quantity' : quantity,
      //'unit_price' : unit_price,
      'total_value' : total_value
    };
    String token = await getToken();
    final response = await http.post(
      Uri.parse(postOrder),
      body: jsonEncode(body),
      headers: {
        'Authorization' : 'Bearer $token',
        'Content-type' : 'application/json'
      }
    );
    //final data = jsonEncode(body);
    print(response.body);
  }
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController quantityControl = TextEditingController();
  TextEditingController priceControl = TextEditingController();
  TextEditingController totalControl = TextEditingController();
  @override
  Widget build(BuildContext context){
    String nameProduct = widget.productName;
    String quantityProduct = widget.productQuantity;
    String priceProduct = widget.productPrice;

    int parsedQuantity = int.tryParse(quantityControl.text) ?? 0;
    int parsedPrice = int.tryParse(priceProduct) ?? 0;
    nameControl.text = nameProduct;
    //quantityControl.text = quantityProduct;
    priceControl.text = priceProduct;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Form'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back))
        ],
      ), 
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameControl,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val){
                if(val!.isEmpty){
                  return 'Field required';
                }
                final intValue = int.tryParse(val);
                if(intValue! > parsedQuantity){
                  return 'Not enough quantity';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: quantityProduct
              ),
              controller: quantityControl,
            ),
            TextFormField(
              controller: priceControl,
              enabled: false,
            ),
            ElevatedButton(onPressed: (){
                int totalValue = parsedQuantity * parsedPrice;
                print(parsedQuantity);
                print(parsedPrice);
                print(totalValue);
                totalControl.text = totalValue.toString();
                setState(() {
                  
                });
            }, child: const Text('Equals')),
            TextFormField(
              controller: totalControl,
            ),
            ElevatedButton(onPressed: (){
              postDataFromStaff();
            }, child: const Text('SUBMIT'))
          ],
        )
      ),
    );
  }
}