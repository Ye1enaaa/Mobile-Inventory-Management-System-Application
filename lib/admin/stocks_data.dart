import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_inventory_system/admin/admin_instance.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
class StocksData extends StatefulWidget {
  const StocksData({ Key? key }) : super(key: key);

  @override
  _StocksDataState createState() => _StocksDataState();
}

class _StocksDataState extends State<StocksData> {

  Future<List<Products>> fetchProductData()async{
    final response = await http.get(Uri.parse(productStocks));
    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final productStocks = (data['products'] as List)
        .map((e) => Products.fromMap(e)).toList();
      return productStocks;
    }else{
      throw Exception('error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('Stocks', style: GoogleFonts.poppins(
          color: Colors.black
        )),
        elevation: 0,
        backgroundColor: Colors.white54,
      ),
      body: Center(
        child: FutureBuilder<List<Products>>(
          future: fetchProductData(),
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              final products =snapshot.data!;
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }else if(snapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context,index){
                    final product = products[index];
                    return Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid
                          )
                        )
                      ),
                      child: Row(
                        children: [
                          QrImage(
                            data: product.productCode,
                            version: QrVersions.auto,
                            size: 170,
                          ),
                          const SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              Text('Name: ${product.name}', 
                                style: GoogleFonts.poppins(
                                  fontSize: 28
                              )),
                              const SizedBox(height: 10),
                              Text('Price: ${product.unitPrice}.00',
                                style: GoogleFonts.poppins(
                                  fontSize: 22
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Quantity: ${product.quantity}',
                                style: GoogleFonts.poppins(
                                  fontSize: 20
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Total Value: ${product.inventoryValue}.00',
                                style: GoogleFonts.poppins(
                                  fontSize: 20
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                );
              }
            }else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}