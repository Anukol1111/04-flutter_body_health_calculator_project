import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// สีและสไตล์ที่ใช้ร่วมกัน (ดูดสีมาจาก Figma)
class AppColors {
  static const Color primary = Color(0xFFDB3500); // AppBar / Splash
  static const Color button = Color(0xFFFF5722); // ปุ่มคำนวณ
  static const Color clearButton = Color(0xFFB6B4BB); // ปุ่มล้างข้อมูล
  static const Color resultBox = Color(0xFFC8E6C9); // กล่องผลลัพธ์
  static const Color resultValue = Color(0xFFF44336); // ตัวเลขผลลัพธ์
  static const Color heading = Color(0xFF424242);
}

// ข้อความหัวช่องกรอก เช่น "น้ำหนัก (kg.)"
Widget fieldLabel(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: GoogleFonts.kanit(fontSize: 14)),
  );
}

// ช่องกรอกตัวเลข
Widget numberField(TextEditingController controller, String hint) {
  return TextField(
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      hintText: hint,
      border: const OutlineInputBorder(),
    ),
  );
}

// ปุ่มยาวเต็มความกว้าง (คำนวณ / ล้างข้อมูล)
Widget fullButton({
  required String text,
  required Color color,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 55),
    ),
    child: Text(
      text,
      style: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  );
}

// กล่องแสดงผลลัพธ์ เช่น BMI 0.00 การแปลผล
Widget resultBox({
  required String title,
  required String value,
  required String note,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 22),
    decoration: BoxDecoration(
      color: AppColors.resultBox,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: GoogleFonts.kanit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.kanit(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: AppColors.resultValue,
          ),
        ),
        Text(
          note,
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}

// แจ้งเตือนเมื่อกรอกข้อมูลไม่ครบหรือไม่ถูกต้อง
void showWarning(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message, style: GoogleFonts.kanit())),
    );
}
