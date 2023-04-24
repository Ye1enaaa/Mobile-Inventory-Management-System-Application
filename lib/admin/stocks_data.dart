import 'package:flutter/material.dart';

class StocksData extends StatefulWidget {
  const StocksData({ Key? key }) : super(key: key);

  @override
  _StocksDataState createState() => _StocksDataState();
}

class _StocksDataState extends State<StocksData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks'),
      ),
    );
  }
}