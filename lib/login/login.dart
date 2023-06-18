import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_inventory_system/API%20Response/api_response.dart';
import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:mobile_inventory_system/pages/staff_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/admin.dart';
import '../pages/root_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
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
      int status = await getStatus();
      int role = await getRole();
      if(status == 0){
        if(role == 3){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Customer()));
        } else if(role == 2){
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Admin()));
      } // ignore: use_build_context_synchronously
      } else if(status == 1){
        print('Account Disabled');
      }
    } 
    
  }

  void saveToken(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('role', user.role ?? 0);
    await pref.setInt('disabled', user.disabled ?? 0);
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
            child: Form(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                      width: 250,
                      height: 250,
                      child: Image.asset(
                        'assets/login.png',
                        fit: BoxFit.cover,
                      ),
                  ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text('Login', style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 35),
                      Container(
                        width: 360,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white60,
                              spreadRadius: 2,
                              blurRadius: 15
                            )
                          ],
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                            
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Email ID",
                            hintStyle: GoogleFonts.poppins(),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 35),
                      Container(
                        width: 360,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white60,
                              spreadRadius: 2,
                              blurRadius: 15
                            )
                          ],
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                            
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: GoogleFonts.poppins(),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: loginNow,
                        child: Container(
                          width: 360,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login', style: GoogleFonts.poppins(
                                fontSize: 22
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ),
      )
    );
  }
}