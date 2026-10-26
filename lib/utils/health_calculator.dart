// สูตรคำนวณตาม Figma

// BMI = น้ำหนัก (kg) ÷ (ส่วนสูง (m) × ส่วนสูง (m))
double calculateBmi({required double weightKg, required double heightCm}) {
  final heightM = heightCm / 100;
  return weightKg / (heightM * heightM);
}

// การแปลผล BMI
String bmiResult(double bmi) {
  if (bmi < 18.5) return 'น้ำหนักต่ำกว่าเกณฑ์';
  if (bmi < 23.0) return 'น้ำหนักสมส่วน';
  if (bmi < 25.0) return 'น้ำหนักเกิน';
  if (bmi < 30.0) return 'โรคอ้วนระดับ 1';
  return 'โรคอ้วนระดับ 2 หรืออ้วนมาก';
}

// BMR (kcal/day)
// ผู้ชาย: 88.362 + (13.397 × น้ำหนัก) + (4.799 × ส่วนสูง) - (5.677 × อายุ)
// ผู้หญิง: 447.593 + (9.247 × น้ำหนัก) + (3.098 × ส่วนสูง) - (4.330 × อายุ)
double calculateBmr({
  required bool isMale,
  required double weightKg,
  required double heightCm,
  required double age,
}) {
  if (isMale) {
    return 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * age);
  }
  return 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * age);
}
