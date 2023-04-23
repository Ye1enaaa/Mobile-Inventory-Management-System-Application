import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
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
                    return Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 60),
                            Row(
                              children: [
                                const SizedBox(width: 30),
                                Container(
                                  height: 200,
                                  width: 170,        
                                  decoration: BoxDecoration(
                                    color: Colors.orange[400],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          SizedBox(width: 70),
                                          Icon(LineIcons.wineGlass, size: 90)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                            '${snapshot.data!.products_quantity} pcs',
                                            style: GoogleFonts.poppins(
                                              fontSize: 25
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text('Liquor Quantity', 
                                            style: GoogleFonts.fredoka(
                                              fontSize: 21,
                                              
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 35),
                                Container(
                                  height: 200,
                                  width: 170,        
                                  decoration: BoxDecoration(
                                    color: Colors.blue[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          SizedBox(width: 70),
                                          Icon(LineIcons.fileInvoiceWithUsDollar, size: 90)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                            '${snapshot.data!.inventory_value} PHP',
                                            style: GoogleFonts.poppins(
                                              fontSize: 25
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text('Inventory Value', 
                                            style: GoogleFonts.fredoka(
                                              fontSize: 21,
                                              
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 30),
                                Container(
                                  height: 200,
                                  width: 170,        
                                  decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          SizedBox(width: 70),
                                          Icon(LineIcons.userFriends, size: 90)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                            '${snapshot.data!.admin_count}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 25
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text('Customer', 
                                            style: GoogleFonts.fredoka(
                                              fontSize: 21,        
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 35),
                                Container(
                                  height: 200,
                                  width: 170,        
                                  decoration: BoxDecoration(
                                    color: Colors.blue[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          SizedBox(width: 70),
                                          Icon(LineIcons.barChartAlt, size: 90)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                            '${snapshot.data!.orders_value} PHP',
                                            style: GoogleFonts.poppins(
                                              fontSize: 25
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text('Sales', 
                                            style: GoogleFonts.fredoka(
                                              fontSize: 21,
                                              
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 30),
                                Container(
                                  height: 200,
                                  width: 170,        
                                  decoration: BoxDecoration(
                                    color: Colors.orange[200],
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Row(
                                        children: const [
                                          SizedBox(width: 70),
                                          Icon(LineIcons.shoppingBag, size: 90)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          Text(
                                            '${snapshot.data!.product_count} pcs',
                                            style: GoogleFonts.poppins(
                                              fontSize: 25
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Row(
                                        children: [
                                          const SizedBox(width: 5),
                                          Text('Products', 
                                            style: GoogleFonts.fredoka(
                                              fontSize: 21,        
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                //const SizedBox(width: 35)
                              ],
                            )
                          ],
                        )
                      ],
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