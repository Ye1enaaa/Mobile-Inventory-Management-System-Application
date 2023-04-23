// ignore_for_file: non_constant_identifier_names

class Dashboard{
  final int products_quantity;
  final int inventory_value;
  final String orders_value;
  final int admin_count;
  final int product_count;

  const Dashboard({
    required this.products_quantity,
    required this.inventory_value,
    required this.orders_value,
    required this.admin_count,
    required this.product_count
  });

  factory Dashboard.fromJson(Map<String, dynamic> json){
    return Dashboard(
      products_quantity: json['products_quantity'], 
      inventory_value: json['inventory_value'], 
      orders_value: json['orders_value'], 
      admin_count: json['admin_count'],
      product_count: json['product_count']
    );
  }
}