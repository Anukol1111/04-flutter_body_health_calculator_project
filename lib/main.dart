import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'views/splash_screen_ui.dart';

void main() {
  runApp(const FlutterBodyHealthCalculatorProject());
}

class FlutterBodyHealthCalculatorProject extends StatelessWidget {
  const FlutterBodyHealthCalculatorProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body ว้าว',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // ฟอนต์หลักของแอป: Kanit
        textTheme: GoogleFonts.kanitTextTheme(),
        // ให้ขนาดปุ่ม/ช่องกรอกเท่ากันทุกแพลตฟอร์ม (บนเว็บ/คอมจะเล็กลงถ้าไม่กำหนด)
        visualDensity: VisualDensity.standard,
      ),
      // หน้าแรกของแอป
      home: const SplashScreenUI(),
    );
  }
}
