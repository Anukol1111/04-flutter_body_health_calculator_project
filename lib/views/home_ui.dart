import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_style.dart';
import 'about_ui.dart';
import 'bmi_ui.dart';
import 'bmr_ui.dart';

// หน้าหลัก: AppBar + BottomNavigationBar สลับหน้า BMI / About / BMR
class HomeUI extends StatefulWidget {
  const HomeUI({super.key, this.initialIndex = 1});

  // แท็บที่เปิดเป็นแท็บแรก (1 = About ตาม Figma)
  final int initialIndex;

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  late int _currentIndex = widget.initialIndex;

  final List<Widget> _pages = const [BmiUI(), AboutUI(), BmrUI()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Body Health Calculator',
          style: GoogleFonts.kanit(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      // IndexedStack เก็บค่าที่กรอกไว้ตอนสลับแท็บ
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: GoogleFonts.kanit(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.kanit(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'BMI'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'About'),
          // ไอคอนใน Figma ไม่มีใน Flutter Icons จึงใช้รูปคนนั่งที่ใกล้ที่สุดแทน
          BottomNavigationBarItem(
            icon: Icon(Icons.airline_seat_recline_normal),
            label: 'BMR',
          ),
        ],
      ),
    );
  }
}
