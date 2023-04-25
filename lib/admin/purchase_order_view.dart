import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_inventory_system/constants/constants.dart';

import 'admin_instance.dart';

class PurchaseOrderView extends StatefulWidget {
  const PurchaseOrderView({ Key? key }) : super(key: key);

  @override
  _PurchaseOrderViewState createState() => _PurchaseOrderViewState();
}

class _PurchaseOrderViewState extends State<PurchaseOrderView> {
  //late Future<PurchaseOrderData> futureData;
  
  Future <List<PurchaseOrder>> fetchData() async{
    final response = await http.get(Uri.parse(purchaseOrderUrl));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final purchaseOrders = (data['purchaseOrder'] as List)
        .map((e) => PurchaseOrder.fromMap(e)).toList();
      return purchaseOrders;
    }else{
      throw Exception('Error');
    }
  }

  Future reload() async {
    final response = await http.get(Uri.parse(purchaseOrderUrl));
    final decode = jsonDecode(response.body) as Map;
    final decoded = decode['purchaseOrder'] as List;
    print(decoded);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureData = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('Sales', style: GoogleFonts.poppins(
          color: Colors.black
        )),
        elevation: 0,
        backgroundColor: Colors.white54,
      ),
      body: Center(
        child: FutureBuilder<List<PurchaseOrder>>(
          future: fetchData(),
          builder: (BuildContext context, snapshot){
              if(snapshot.hasData){
                  final purchaseOrders = snapshot.data!;
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }else if(snapshot.connectionState == ConnectionState.done){
                    return RefreshIndicator(
                      onRefresh: fetchData,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: purchaseOrders.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text(purchaseOrders[index].name),
                            subtitle: Text(purchaseOrders[index].userId.toString()),
                          );
                        }
                      ),
                    );
                  }
              }else if(snapshot.hasError){
                return Text('$snapshot.error');
              }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}