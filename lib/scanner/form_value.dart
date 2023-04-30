import 'package:flutter/material.dart';

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
  var formKey = GlobalKey<FormState>();
  TextEditingController nameControl = TextEditingController();
  TextEditingController quantityControl = TextEditingController();
  TextEditingController priceControl = TextEditingController();

  void returnTotalValue(){
  }
  
  @override
  Widget build(BuildContext context){
    String nameProduct = widget.productName;
    String quantityProduct = widget.productQuantity;
    String priceProduct = widget.productPrice;
    int parsedQuantity = int.parse(quantityProduct);
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

            }, child: const Text('SUBMIT')),
            TextFormField(

            )
          ],
        )
      ),
    );
  }
}