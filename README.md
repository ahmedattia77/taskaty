# 📱 Bookia - Mobile Application

A features-rich, beautifully designed mobile application built with **Flutter** following **Clean Architecture** principles and robust software design patterns. The project emphasizes reactive UI states, solid error handling, offline connection auto-recovery, and localized themes.

---
## 📸 Overview & dimo video


https://github.com/user-attachments/assets/a9564c4c-a6ad-4058-ae5d-dd6d741fc280


## 📸 Overview & Features

* **Clean Architecture Standard**: Clear separation of concerns into Data, Domain, and Presentation layers.
* **State Management**: Scalable state management powered by **BLoC / Cubit**.
* **Real-time Network Monitoring**: Continuous connectivity tracking with automatic UI recovery (`Auto-Healing UI`) upon network reconnection.
* **Automated Security**: Custom Dio Interceptors for seamless Bearer Token injection on authenticated endpoints.
* **Dynamic System UI & Theme**: Smooth integration with device themes, featuring dynamic status bar transparency and adaptive icon brightness.
* **Dependency Injection**: Fast, clean service locator setup using **GetIt**.
* **Responsive UI Design**: Pixel-perfect responsive layouts scaled for all mobile device sizes via `flutter_screenutil`.

---

## 🛠 Tech Stack & Architecture

* **Framework**: [Flutter](https://flutter.dev/) (Dart)
* **Architecture**: Clean Architecture (Data, Domain, Presentation)
* **State Management**: `flutter_bloc` / `cubit`
* **Network & REST API**: `dio`
* **Network Checking**: `internet_connection_checker_plus`
* **Dependency Injection**: `get_it`
* **Local Storage**: `shared_preferences` / `hive`
* **Screen Responsiveness**: `flutter_screenutil`

---

## 📁 Project Structure

```text
lib/
├── core/
│   ├── database/        # Local storage (CacheHelper, SecureStorage)
│   ├── errors/          # Exception & Failure handlers
│   ├── network/         # Dio client, interceptors & network status checking
│   ├── routing/         # App routing & navigation logic
│   ├── theme/           # App colors, themes & system UI overlay settings
│   └── utils/           # Shared constants, helpers & custom widgets
├── features/
│   ├── auth/            # Authentication feature (Login, Register, Token Mgmt)
│   ├── welcome/         # Onboarding & Welcome screens
│   └── home/            # Main dashboard, tasks management & reactive UI logic
└── main.dart            # Entry point & app setup
