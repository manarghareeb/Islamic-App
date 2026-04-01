<div align="center">

# 🕌 Islamic App

**A comprehensive Islamic companion app built with Flutter — featuring Quran, Prayer Times, Adhkar, Tasbih, and Daily Reminders.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)](https://dart.dev)
[![BLoC](https://img.shields.io/badge/State%20Management-BLoC-blueviolet)](https://bluelibs.com/docs/x-ui/core-concepts/state-management/bloc)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-orange)]()

</div>

---

## 📖 Project Overview

**Islamic App** is a beautifully designed, all-in-one Islamic mobile application built with Flutter. It serves as a daily spiritual companion for Muslims — offering accurate GPS-based prayer times, full Quran browsing, Adhkar (supplications), a digital Tasbih counter, and customizable daily reminders, all wrapped in an elegant RTL-compatible Arabic UI.

The app is built following **Clean Architecture** principles with a feature-first folder structure, making it highly maintainable and scalable.

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter (Dart 3.10+) |
| **State Management** | Flutter BLoC / Cubit |
| **Navigation** | GoRouter |
| **Networking** | Dio + REST APIs |
| **Local Storage** | Hive (NoSQL) + SharedPreferences |
| **Notifications** | flutter_local_notifications |
| **Location** | Geolocator |
| **Timezone** | flutter_timezone + timezone |
| **DI / Service Locator** | get_it |
| **Functional Programming** | dartz (Either, Failures) |
| **UI Utilities** | flutter_screenutil, flutter_svg, smooth_page_indicator |
| **Internationalization** | intl |
| **Code Generation** | hive_generator + build_runner |

---

## 🏗️ Architecture

The project strictly follows **Clean Architecture** with a **feature-first** modular structure. Each feature is self-contained with its own Data, Domain, and Presentation layers.

```
Feature
├── data/
│   ├── data_sources/     # Remote & local data sources
│   ├── models/           # JSON-serializable models (extends entities)
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Pure business objects
│   ├── repositories/     # Abstract repository interfaces
│   └── usecases/         # Single-responsibility use cases
└── presentation/
    ├── cubit/            # BLoC Cubits (states & logic)
    ├── views/            # Full screens
    └── widgets/          # Reusable UI components
```

**Key architectural decisions:**

- **dartz `Either<Failure, T>`** is used across all use cases for type-safe error handling — no exceptions bubble up to the UI layer.
- **GetIt** acts as the service locator, wiring together all dependencies in `service_locator.dart`.
- **GoRouter** handles all navigation declaratively, with route constants defined in `AppRouter`.
- **Hive** provides fast, offline-first persistence for Tasbih counters and Reminders.
- The **ApiConsumer** abstraction (`DioConsumer`) keeps networking decoupled from business logic.

---

## ✨ Features

### 🕋 Home Dashboard
- Greeting header with a dynamic "Ayah of the Day" card
- Service grid linking to all major features (Prayer Times, Quran, Adhkar, Tasbih, Reminders)
- Live prayer countdown visible directly on the home screen

### 🕐 Prayer Times
- Fetches accurate daily prayer times using the **Aladhan API** based on the user's real GPS coordinates
- Displays Fajr, Sunrise, Dhuhr, Asr, Maghrib, and Isha with icons
- Shows both **Gregorian and Hijri dates** including the Arabic weekday
- Toggle notifications on/off per-prayer — settings are persisted across sessions
- Schedules exact timezone-aware local notifications for each enabled prayer

### 📗 Quran
- Full Quran browsing via the **AlQuran Cloud API**
- Browse all Surahs and read Ayahs within each Surah
- Random Ayah of the Day displayed on the home screen

### 📿 Adhkar (Supplications)
- Categorized Adhkar loaded from a local JSON asset (`adhkar.json`) — works fully offline
- Interactive tap-to-count repetition system with repeat tracking per dhikr
- Clean card-based UI with category browsing and detail screens

### 📿 Tasbih Counter
- Digital Tasbih with customizable target count
- Add, rename, and manage multiple Tasbih sessions
- Data persisted via **Hive** — your count survives app restarts
- Smooth animated counter with a large tap-friendly button

### 🔔 Reminders
- Create custom daily reminders with a title and time picker
- Enable/disable individual reminders with a toggle
- Backed by **Hive** for offline storage and **flutter_local_notifications** for delivery

### 🚀 Onboarding & Splash
- Animated splash screen on first launch
- Multi-page onboarding flow with smooth page indicator
- "Skip" and "Next" navigation controls; onboarding is shown only once via SharedPreferences

---

## 🧪 Testing

The project uses Flutter's built-in testing framework. Dev dependencies include:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.8
  hive_generator: ^2.0.1
```

To run all tests:

```bash
flutter test
```

> Note: Unit tests for use cases and repository implementations are the recommended next step to increase coverage. The Clean Architecture structure makes each layer independently testable without UI or network dependencies.

---

## 📁 Folder Structure

```
islamic_app/
├── lib/
│   ├── core/
│   │   ├── api/                  # ApiConsumer, DioConsumer, interceptors, endpoints
│   │   ├── cache/                # CacheHelper (SharedPreferences wrapper)
│   │   ├── di/                   # service_locator.dart (GetIt setup)
│   │   ├── error/                # Failure classes, Exception handlers, ErrorModel
│   │   ├── routing/              # AppRouter (GoRouter config & route constants)
│   │   ├── services/             # LocalNotificationsService
│   │   ├── theme/                # AppColors, AppStyles, AppImages
│   │   └── widgets/              # Shared widgets (AppBar, GradientCard, Header, etc.)
│   │
│   ├── features/
│   │   ├── onboarding/           # Splash & Onboarding screens
│   │   ├── home/                 # Home dashboard
│   │   ├── prayer_times/         # Prayer times (remote API + notifications)
│   │   ├── quran/                # Quran browser (remote API)
│   │   ├── adhkar/               # Adhkar/Supplications (local JSON)
│   │   ├── tasbih/               # Tasbih counter (Hive persistence)
│   │   └── reminders/            # Daily reminders (Hive + notifications)
│   │
│   └── main.dart                 # App entry point (Hive init, DI, notifications)
│
├── assets/
│   ├── images/                   # Splash & UI images
│   ├── fonts/cairo/              # Cairo font family (Regular, Medium, SemiBold, Bold)
│   └── json/adhkar.json          # Offline Adhkar data
│
├── android/                      # Android native project
├── ios/                          # iOS native project
├── pubspec.yaml                  # Dependencies & assets manifest
└── README.md
```

---

## 🚀 How to Run the Project

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.10.0`
- Dart `>=3.10.0`
- Android Studio / VS Code with Flutter extension
- A connected device or emulator

### Steps

**1. Clone the repository**

```bash
git clone https://github.com/your-username/islamic_app.git
cd islamic_app
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Generate Hive adapters** (if modifying models)

```bash
dart run build_runner build --delete-conflicting-outputs
```

**4. Run the app**

```bash
flutter run
```

**5. Build for release (Android)**

```bash
flutter build apk --release
```

> **Note:** The app requires location permissions at runtime to fetch accurate prayer times. Make sure to grant location access when prompted.

---

## 🔮 Future Improvements

- [ ] **Qibla Direction** — Compass-based Qibla finder using device sensors
- [ ] **Nearest Mosques Map** — Integrate Google Maps to find nearby mosques
- [ ] **Quran Audio** — Audio recitation playback for each Surah/Ayah
- [ ] **Quran Bookmarks & Search** — Save favorite Ayahs and search by keyword
- [ ] **Dark Mode** — Full dark theme support with theme-switching
- [ ] **Localization (i18n)** — Multi-language support (English, Arabic, Urdu, etc.)
- [ ] **Hijri Calendar** — Full interactive Hijri calendar view
- [ ] **Widget Support** — Home screen widget showing the next prayer time
- [ ] **Unit & Widget Tests** — Comprehensive test coverage for use cases and UI
- [ ] **CI/CD Pipeline** — Automated testing and deployment via GitHub Actions

---

## 📸 Screenshots

> Add your screenshots here to showcase the app's UI.

| Home Screen | Prayer Times | Quran |
|:-----------:|:------------:|:-----:|
| ![HomePage](https://github.com/user-attachments/assets/81e5a226-9066-4e60-8949-330295463e39) | ![prayer times](https://github.com/user-attachments/assets/935cc31d-d9fd-46fc-b32d-f0b4a72491bb) | ![quran](https://github.com/user-attachments/assets/620b67d9-10a4-4ce1-8e5c-72fe02524825) |


| Adhkar | Tasbih | Reminders |
|:------:|:------:|:---------:|
| ![akhar](https://github.com/user-attachments/assets/09da9276-3290-448e-8420-56d4b3083536) | ![masbaha](https://github.com/user-attachments/assets/4a839447-0edc-40e5-af88-2cc189a2c5ac) | ![add note](https://github.com/user-attachments/assets/2fc38292-9f6b-436a-bef9-7cb7354e573a) |

---

## 🔗 APIs Used

| API | Purpose | Docs |
|-----|---------|------|
| [AlQuran Cloud](https://alquran.cloud/api) | Fetch Surahs and Ayahs | `https://api.alquran.cloud/v1/` |
| [Aladhan](https://aladhan.com/prayer-times-api) | GPS-based prayer times & Hijri date | `https://api.aladhan.com/v1/` |

---

## 🤝 Contributing

Contributions are very welcome! Here's how to get started:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add amazing feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a Pull Request

Please follow the existing code style and Clean Architecture patterns when contributing.

---

## 📬 Social Links

<div align="center">

[![GitHub](https://img.shields.io/badge/GitHub-@manarghareeb-181717?logo=github)](https://github.com/manarghareeb)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?logo=linkedin)](https://linkedin.com/in/manar-ghareeb)
[![Email](https://img.shields.io/badge/Email-Contact%20Me-D14836?logo=gmail)](mailto:manarghareeb1973@gmail.com)

</div>

---

<div align="center">

Made with ❤️ and Flutter · بسم الله الرحمن الرحيم

</div>
