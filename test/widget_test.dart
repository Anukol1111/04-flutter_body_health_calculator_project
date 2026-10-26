import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_body_health_calculator_project/main.dart';
import 'package:flutter_body_health_calculator_project/utils/health_calculator.dart';
import 'package:flutter_body_health_calculator_project/views/bmi_ui.dart';
import 'package:flutter_body_health_calculator_project/views/bmr_ui.dart';

void main() {
  // ไม่ให้ google_fonts โหลดฟอนต์จากอินเทอร์เน็ตตอนรันเทสต์
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  group('BMI', () {
    test('70 kg, 175 cm = 22.86 (น้ำหนักสมส่วน)', () {
      final bmi = calculateBmi(weightKg: 70, heightCm: 175);
      expect(bmi, closeTo(22.857, 0.001));
      expect(bmiResult(bmi), 'น้ำหนักสมส่วน');
    });

    test('result ranges follow the Figma table', () {
      expect(bmiResult(18.4), 'น้ำหนักต่ำกว่าเกณฑ์');
      expect(bmiResult(18.5), 'น้ำหนักสมส่วน');
      expect(bmiResult(22.9), 'น้ำหนักสมส่วน');
      expect(bmiResult(23.0), 'น้ำหนักเกิน');
      expect(bmiResult(24.9), 'น้ำหนักเกิน');
      expect(bmiResult(25.0), 'โรคอ้วนระดับ 1');
      expect(bmiResult(29.9), 'โรคอ้วนระดับ 1');
      expect(bmiResult(30.0), 'โรคอ้วนระดับ 2 หรืออ้วนมาก');
    });
  });

  group('BMR', () {
    test('male 70 kg, 175 cm, 25 years = 1724.05', () {
      final bmr = calculateBmr(
        isMale: true,
        weightKg: 70,
        heightCm: 175,
        age: 25,
      );
      expect(bmr, closeTo(1724.052, 0.001));
    });

    test('female 60 kg, 165 cm, 30 years = 1383.68', () {
      final bmr = calculateBmr(
        isMale: false,
        weightKg: 60,
        heightCm: 165,
        age: 30,
      );
      expect(bmr, closeTo(1383.683, 0.001));
    });
  });

  testWidgets('Splash → Home, BMI and BMR calculate and clear', (tester) async {
    // ขนาดจอ iPhone 15 Pro Max (430 x 932)
    tester.view.physicalSize = const Size(1290, 2796);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const FlutterBodyHealthCalculatorProject());
    expect(find.text('Body Health Calculator'), findsOneWidget);

    // หลัง 3 วินาทีไปหน้า HomeUI (เปิดแท็บ About ก่อน)
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Developed by NinniN SAU 2026'), findsOneWidget);

    // BMI
    await tester.tap(find.text('BMI').last);
    await tester.pumpAndSettle();
    final bmi = find.byType(BmiUI);
    final bmiFields = find.descendant(
      of: bmi,
      matching: find.byType(TextField),
    );
    await tester.enterText(bmiFields.at(0), '70');
    await tester.enterText(bmiFields.at(1), '175');
    await tester.tap(
      find.descendant(of: bmi, matching: find.text('คำนวณ BMI')),
    );
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: bmi, matching: find.text('22.86')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bmi, matching: find.text('น้ำหนักสมส่วน')),
      findsOneWidget,
    );

    await tester.tap(
      find.descendant(of: bmi, matching: find.text('ล้างข้อมูล')),
    );
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: bmi, matching: find.text('0.00')),
      findsOneWidget,
    );

    // BMR (ผู้หญิง)
    await tester.tap(find.text('BMR').last);
    await tester.pumpAndSettle();
    final bmr = find.byType(BmrUI);
    await tester.tap(find.descendant(of: bmr, matching: find.text('หญิง')));
    final bmrFields = find.descendant(
      of: bmr,
      matching: find.byType(TextField),
    );
    await tester.enterText(bmrFields.at(0), '60');
    await tester.enterText(bmrFields.at(1), '165');
    await tester.enterText(bmrFields.at(2), '30');
    final calc = find.descendant(of: bmr, matching: find.text('คำนวณ BMR'));
    await tester.ensureVisible(calc);
    await tester.tap(calc);
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: bmr, matching: find.text('1383.68')),
      findsOneWidget,
    );

    // ไม่กรอกข้อมูลแล้วกดคำนวณ: มีแจ้งเตือน
    final clear = find.descendant(of: bmr, matching: find.text('ล้างข้อมูล'));
    await tester.ensureVisible(clear);
    await tester.tap(clear);
    await tester.pumpAndSettle();
    await tester.tap(calc);
    await tester.pump();
    expect(
      find.text('กรุณากรอกน้ำหนัก ส่วนสูง และอายุให้ถูกต้อง'),
      findsOneWidget,
    );
  });
}
