import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  const Customer({ Key? key }) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Customer'),
      ),
    );
  }
}