import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_inventory_system/scanner/qr_scanner.dart';
import 'package:mobile_inventory_system/scanner/stock_in.dart';

import '../Stock Out/stock_out_scan.dart';
import '../login/login.dart';
class Customer extends StatefulWidget {
  const Customer({ Key? key }) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  Future<Map<String,dynamic>> fetchUser() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userUrl),
      headers: {
        'Authorization' : 'Bearer $token'
      }
    );
    if(response.statusCode == 200){
      final Map <String, dynamic> data = json.decode(response.body);
      return data['user'];
    }else{
      throw Exception('Error');
    }
  }
  void removeTokenRole()async{
    removeRole();
    await logOutRemoveToken();
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: FutureBuilder<Map<String,dynamic>>(
            future: fetchUser(),
            builder: (BuildContext context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("404 Error");
                }else if(snapshot.hasData){
                  final data = snapshot.data!;
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.black),
                          image: const DecorationImage(
                            image: AssetImage('assets/User.jpg'),
                            fit: BoxFit.cover
                          )
                        )
                      ),
                      const SizedBox(height: 30),
                      Text('Name: ${data['name']}', style: GoogleFonts.poppins(fontSize: 20)),
                      const SizedBox(height: 5),
                      Text('Email: ${data['email']}', style: GoogleFonts.poppins(fontSize: 18)),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: ()async{
                          removeTokenRole();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: const [
                              SizedBox(width: 15),
                              Icon(LineIcons.alternateSignOut),
                              SizedBox(width: 5),
                              Text('Log Out')
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  );
                }
              }
              return const CircularProgressIndicator();
            }
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('Staff', style: GoogleFonts.poppins(color:Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white38,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Text('Stock Management', style: GoogleFonts.poppins(
            color:Colors.black,
            fontSize: 30
            )
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const SizedBox(width: 70),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const QrScanner()));
                },
                child: Ink(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text('Stock In', style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.black
                    )),
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              const SizedBox(width: 70),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const StockOutScan()));
                },
                child: Ink(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text('Stock Out', style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.black
                    )),
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}