# 04-flutter_body_health_calculator_project

**Body ว้าว** — a BMI and BMR calculator built from the Figma design
"Project: flutter_body_health_calculator_project" (tested at iPhone 15 Pro Max size, 430 x 932).
Main font: Kanit (google_fonts).

## Screens

| File | Class | Screen |
| --- | --- | --- |
| `lib/views/splash_screen_ui.dart` | `SplashScreenUI` (stf) | First page with a loading spinner, goes to HomeUI after 3 seconds |
| `lib/views/home_ui.dart` | `HomeUI` (stf) | AppBar + BottomNavigationBar: BMI / About / BMR (opens on About) |
| `lib/views/bmi_ui.dart` | `BmiUI` (stf) | Weight + height → BMI and its meaning |
| `lib/views/bmr_ui.dart` | `BmrUI` (stf) | Gender + weight + height + age → BMR (kcal/day) |
| `lib/views/about_ui.dart` | `AboutUI` (stl) | About the app |

Formulas are in `lib/utils/health_calculator.dart`; shared colors and widgets in `lib/widgets/app_style.dart`.

## Formulas

- BMI = weight (kg) ÷ (height (m) × height (m))
  - < 18.5 น้ำหนักต่ำกว่าเกณฑ์ · 18.5–22.9 น้ำหนักสมส่วน · 23.0–24.9 น้ำหนักเกิน · 25.0–29.9 โรคอ้วนระดับ 1 · ≥ 30.0 โรคอ้วนระดับ 2 หรืออ้วนมาก
- BMR (male) = 88.362 + 13.397 × weight + 4.799 × height (cm) − 5.677 × age
- BMR (female) = 447.593 + 9.247 × weight + 3.098 × height (cm) − 4.330 × age

## Run

```sh
flutter pub get
flutter run -d chrome
```

## Quality checks

```sh
flutter analyze
flutter test
```
