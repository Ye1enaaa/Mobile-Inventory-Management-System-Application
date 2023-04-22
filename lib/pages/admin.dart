import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/constants/constants.dart';

import '../admin/admin_instance.dart';
class Admin extends StatefulWidget {
  const Admin({ Key? key }) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Future<Dashboard> fetchDashboard()async{
    final response = await http.get(Uri.parse(dashboardUrl));

    if(response.statusCode == 200){
      return Dashboard.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed');
    }
  }

  //late Future<Dashboard> futureDashboard;
  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin'),
      ),
      body: Center(
        child: FutureBuilder<Dashboard>(
          future: fetchDashboard(),
          builder: (BuildContext context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Visibility(
                        visible: snapshot.hasData,
                        child: Text(
                          snapshot.data!.orders_value,
                          style: const TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      )
                    ],
                  );
                } else if(snapshot.connectionState == ConnectionState.done){
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 30),
                              Container(
                                height: 200,
                                width: 170,
                                decoration: BoxDecoration(border: Border.all(
                                  color: Colors.black,
                                  width: 1 ),
                                ),
                                child: Text(snapshot.data!.orders_value),
                              ),
                              const SizedBox(width: 40),
                              Container(
                                height: 200,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                  color: Colors.black,
                                  width: 1 
                                )),
                                child: Text(snapshot.data!.inventory_value.toString()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('Empty data');
                  }
                }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}