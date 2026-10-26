import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/health_calculator.dart';
import '../widgets/app_style.dart';

// หน้าคำนวณหาค่าดัชนีมวลกาย (BMI)
class BmiUI extends StatefulWidget {
  const BmiUI({super.key});

  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  double _bmi = 0;
  String _result = 'การแปลผล';

  @override
  void dispose() {
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    final weight = double.tryParse(_weightCtrl.text.trim());
    final height = double.tryParse(_heightCtrl.text.trim());
    if (weight == null || height == null || weight <= 0 || height <= 0) {
      showWarning(context, 'กรุณากรอกน้ำหนักและส่วนสูงให้ถูกต้อง');
      return;
    }
    FocusScope.of(context).unfocus();
    final bmi = calculateBmi(weightKg: weight, heightCm: height);
    setState(() {
      _bmi = bmi;
      _result = bmiResult(bmi);
    });
  }

  void _clear() {
    _weightCtrl.clear();
    _heightCtrl.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _bmi = 0;
      _result = 'การแปลผล';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(40, 50, 40, 30),
      child: Column(
        children: [
          Text(
            'คำนวณหาค่าดัชนีมวลกาย (BMI)',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 20),
          Image.asset('assets/images/bmi.png', width: 150, height: 150),
          const SizedBox(height: 18),
          fieldLabel('น้ำหนัก (kg.)'),
          const SizedBox(height: 8),
          numberField(_weightCtrl, 'กรอกน้ำหนักของคุณ'),
          const SizedBox(height: 18),
          fieldLabel('ส่วนสูง (cm.)'),
          const SizedBox(height: 8),
          numberField(_heightCtrl, 'กรอกส่วนสูงของคุณ'),
          const SizedBox(height: 22),
          fullButton(
            text: 'คำนวณ BMI',
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
            title: 'BMI',
            value: _bmi.toStringAsFixed(2),
            note: _result,
          ),
        ],
      ),
    );
  }
}
