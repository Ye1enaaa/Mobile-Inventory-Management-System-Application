import 'dart:convert';

import 'package:mobile_inventory_system/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ApiResponse{
  Object? data;
  String? error;
}

class User{
  int? id;
  String? name;
  String? email;
  int? disabled;
  int? role;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.disabled,
    this.role,
    this.token
  });

  factory User.fromJson(Map<String,dynamic> json){
  return User(
    id: json['user']['id'],
    name: json['user']['name'],
    email: json['user']['email'],
    disabled: json['user']['disable'],
    role: json['user']['role'],
    token: json['token']
  );
  }
}

Future<String> getToken() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getRole() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('role') ?? 0;
}

Future<ApiResponse> getUserDetail()async{
  ApiResponse apiResponse = ApiResponse();
    String token = await getToken();
    int role = await getRole();
    final response = await http.get(
      Uri.parse(userUrl),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
    if(response.statusCode == 200){
      apiResponse.data = User.fromJson(jsonDecode(response.body));
    }
  print(apiResponse.data);
  print(token);
  print(role);
  return apiResponse;
}