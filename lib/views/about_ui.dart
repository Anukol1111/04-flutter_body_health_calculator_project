import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_style.dart';

// หน้าเกี่ยวกับแอป (StatelessWidget ตามโจทย์)
class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.kanit(fontSize: 14);

    // Stack: เนื้อหาหลักอยู่กลางจอ ส่วนโลโก้อยู่ด้านล่าง (ตาม Figma)
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Body Health Calculator',
                  style: GoogleFonts.kanit(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.heading,
                  ),
                ),
                const SizedBox(height: 25),
                Image.asset('assets/images/calculate.png', width: 120),
                const SizedBox(height: 25),
                Text(
                  'คำนวณหาค่าดัชนีมวลกาย (BMI)',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'คำนวณหาค่าแคลอรี่ที่ร่างกายต้องการในแต่ละวัน (BMR)',
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/saulogo.png', width: 60, height: 60),
                const SizedBox(height: 15),
                Text(
                  'Developed by NinniN SAU 2026',
                  style: GoogleFonts.kanit(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
