import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
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
                          border: Border.all( width: 1, color: Colors.black),
                          image: const DecorationImage(
                            image: AssetImage('assets/User.jpg'),
                            fit: BoxFit.cover 
                          )
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('${data['name']}')
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
        title: Text('Customer', style: GoogleFonts.poppins(color:Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white38,
      ),
    );
  }
}