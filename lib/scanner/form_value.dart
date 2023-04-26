import 'package:flutter/material.dart';

class FormValue extends StatelessWidget {
final String productName;
FormValue({ 
  Key? key,
  required this.productName 
}) : super(key: key);
  TextEditingController nameControl = TextEditingController();
  @override
  Widget build(BuildContext context){
    String nameProduct = productName;
    nameControl.text = nameProduct;
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
        child: Column(
          children: [
            TextField(
              controller: nameControl,

            )
          ],
        )
      ),
    );
  }
}