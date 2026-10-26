import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/health_calculator.dart';
import '../widgets/app_style.dart';

// หน้าคำนวณหาอัตราการเผาผลาญที่ร่างกายต้องการ (BMR)
class BmrUI extends StatefulWidget {
  const BmrUI({super.key});

  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  bool _isMale = true;
  double _bmr = 0;

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final weight = double.tryParse(_weightCtrl.text.trim());
    final height = double.tryParse(_heightCtrl.text.trim());
    final age = double.tryParse(_ageCtrl.text.trim());
    if (weight == null ||
        height == null ||
        age == null ||
        weight <= 0 ||
        height <= 0 ||
        age <= 0) {
      showWarning(context, 'กรุณากรอกน้ำหนัก ส่วนสูง และอายุให้ถูกต้อง');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _bmr = calculateBmr(
        isMale: _isMale,
        weightKg: weight,
        heightCm: height,
        age: age,
      );
    });
  }

  void _clear() {
    _weightCtrl.clear();
    _heightCtrl.clear();
    _ageCtrl.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _isMale = true;
      _bmr = 0;
    });
  }

  // ปุ่มเลือกเพศ: ปุ่มที่เลือกเป็นสีฟ้า
  Widget _genderButton(String text, bool male) {
    final selected = _isMale == male;
    return ElevatedButton(
      onPressed: () => setState(() => _isMale = male),
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? Colors.blue[100] : Colors.white,
        foregroundColor: selected ? Colors.blue[900] : Colors.grey[700],
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: GoogleFonts.kanit(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 50, 40, 30),
      child: Column(
        children: [
          Text(
            'คำนวณหาอัตราการเผาผลาญที่\nร่างกายต้องการ (BMR)',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 29),
          Image.asset('assets/images/bmr.png', width: 160, height: 160),
          const SizedBox(height: 30),
          fieldLabel('เพศ'),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _genderButton('ชาย', true)),
              const SizedBox(width: 20),
              Expanded(child: _genderButton('หญิง', false)),
            ],
          ),
          const SizedBox(height: 20),
          fieldLabel('น้ำหนัก (kg.)'),
          const SizedBox(height: 10),
          numberField(_weightCtrl, 'กรอกน้ำหนักของคุณ'),
          const SizedBox(height: 20),
          fieldLabel('ส่วนสูง (cm.)'),
          const SizedBox(height: 10),
          numberField(_heightCtrl, 'กรอกส่วนสูงของคุณ'),
          const SizedBox(height: 20),
          fieldLabel('อายุ (ปี)'),
          const SizedBox(height: 10),
          numberField(_ageCtrl, 'กรอกอายุของคุณ'),
          const SizedBox(height: 22),
          fullButton(
            text: 'คำนวณ BMR',
            color: AppColors.button,
            onPressed: _calculate,
          ),
          const SizedBox(height: 10),
          fullButton(
            text: 'ล้างข้อมูล',
            color: AppColors.clearButton,
            onPressed: _clear,
          ),
          const SizedBox(height: 22),
          resultBox(
            title: 'BMR',
            value: _bmr.toStringAsFixed(2),
            note: 'kcal/day',
          ),
        ],
      ),
    );
  }
}
