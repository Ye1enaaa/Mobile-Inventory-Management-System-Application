import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_inventory_system/pages/customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/admin.dart';
import '../pages/root_page.dart';
class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<ApiResponse>login(String email, String password)async{
    ApiResponse apiResponse = ApiResponse();
    try{
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password}
      );
      switch(response.statusCode){
        case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
        case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
        default:
        apiResponse.error = 'something went wrong';
        break;
      }   
    }
    catch(er){
      apiResponse.error = 'somethig';
    }
    return apiResponse;
  } 

  void loginNow()async{
    ApiResponse response = await login(emailController.text, passwordController.text);
    if(response.error == null){
      saveToken(response.data as User);
      getUserDetail();
      int role = await getRole();
      if(role == 3){
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Customer()));
      } else if(role == 2){
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Admin()));
      }
    } 
  }

  void saveToken(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('role', user.role ?? 0);
    // ignore: use_build_context_synchronously
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>const RootPage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
            ),
            child: Column(
              children: [
                const Text('Welcome!!'),
                const SizedBox(height: 220),
                Form(
                  child: Row(
                    children: [
                      //const SizedBox(width: 16),
                      Container(
                        height: 400,
                        width: 432,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40)
                                  ),
                                  filled: true
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40)
                                  ),
                                  filled: true
                                ),
                              ),
                            ),
                            ElevatedButton(onPressed: (){
                              loginNow();
                            }, child: const Text("SUBMIT"))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}