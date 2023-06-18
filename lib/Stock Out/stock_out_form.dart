import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
class StockOutForm extends StatefulWidget {
final String productName;
final String productID;
final String productQuantity;


const StockOutForm({ 
  Key? key,
  required this.productID,
  required this.productName,
  required this.productQuantity 
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
      'stockQuantityIssued': int.parse(stockQuantitycontrol.text),
      'customerName' : supplierName,
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
    String productQuanti = widget.productQuantity;
    int parsedQuanti = int.tryParse(productQuanti) ?? 0;
    //int parsedQuantity = int.tryParse(quantityControl.text) ?? 0;
    //int parsedPrice = int.tryParse(priceProduct) ?? 0;
    nameControl.text = nameProduct;
    prodIDcontrol.text = productID;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Stock OUT Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameControl,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(LineIcons.shoppingBasket),
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    filled: true,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: prodIDcontrol,
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(LineIcons.hashtag),
                    labelText: 'ID NUMBER',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: customerNamecontrol,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(LineIcons.laughFaceWithBeamingEyes),
                    labelText: 'Customer Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter customer name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: stockQuantitycontrol,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(LineIcons.dollarSign),
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    int parsedValue = int.tryParse(value!) ?? 0;
                    if (parsedValue > parsedQuanti && parsedValue != 0) {
                      return 'Maximum value to be stock out is $parsedQuanti';
                    } else if (value.isEmpty) {
                      return 'Please enter minimum quantity to be stock out';
                    } else if (parsedValue == 0 || parsedValue < 0) {
                      return '$nameProduct is currently out of stock';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      stockOut();
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        'SUBMIT',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                if (parsedQuanti <= 10 && parsedQuanti != 0)
                  Column(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.red[600],
                        size: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$nameProduct has $parsedQuanti pieces left.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.red[800],
                        ),
                      ),
                      Text(
                        'Please contact the administrator for immediate action.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                else if (parsedQuanti > 10)
                  Column(
                    children: [
                      Icon(
                        LineIcons.laughFaceWithBeamingEyesAlt,
                        color: Colors.greenAccent[400],
                        size: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$nameProduct has $parsedQuanti pieces left.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Stock on hand is above the critical level.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'No actions need to be taken.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                else if (parsedQuanti == 0)
                  Column(
                    children: [
                      Icon(
                        LineIcons.dizzyFace,
                        color: Colors.red[400],
                        size: 150,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$nameProduct is out of stock.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.red[400],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Please take immediate action.',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}