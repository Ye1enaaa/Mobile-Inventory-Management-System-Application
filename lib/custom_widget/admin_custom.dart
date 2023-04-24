import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCards extends StatelessWidget {
  IconData icon;
  String textData;
  String cardTitle;
  Color? color;
DashboardCards({ 
  Key? key, 
  required this.icon,
  required this.textData,
  required this.color,
  required this.cardTitle
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      height: 200,
      width: 170,        
      decoration: BoxDecoration(
        color: color,
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
            children: [
              const SizedBox(width: 70),
              Icon(icon, size: 90)
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                textData,
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
              Text(cardTitle, 
                style: GoogleFonts.fredoka(
                  fontSize: 21,        
              ))
            ],
          )
        ],
      ),
    );
  }
}