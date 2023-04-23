class UserOnly{
  final String name;
  final String email;
  final String token;
  UserOnly({
    required this.name,
    required this.email,
    required this.token
  });
  
  factory UserOnly.fromJson(Map<String, dynamic> json){
    return UserOnly(
      name: json['user']['name'], 
      email: json['user']['email'],
      token: json['token']
    );
  }
}