# 📱 Bookia - Mobile Application

A features-rich, beautifully designed mobile application built with **Flutter** following **Clean Architecture** principles and robust software design patterns. The project emphasizes reactive UI states, solid error handling, offline connection auto-recovery, and localized themes.

---
## 📸 Overview & Demo Video



https://github.com/user-attachments/assets/c32f5103-3adc-493d-8aec-39336f6b7b5a


---

## 📸 Overview & Features

* **Clean Architecture Standard**: Clear separation of concerns into Data, Domain, and Presentation layers.
* **State Management**: Scalable state management powered by **BLoC / Cubit**.
* **Smart Search Feature**: Advanced, fast, and responsive dynamic search functionality for browsing books and content efficiently.
* **Real-time Network Monitoring**: Continuous connectivity tracking with automatic UI recovery (`Auto-Healing UI`) upon network reconnection.
* **Automated Security**: Custom Dio Interceptors for seamless Bearer Token injection on authenticated endpoints.
* **Dynamic System UI & Theme**: Smooth integration with device themes, featuring dynamic status bar transparency and adaptive icon brightness.
* **Dependency Injection**: Fast, clean service locator setup using **GetIt**.
* **Responsive UI Design**: Pixel-perfect responsive layouts scaled for all mobile device sizes via `flutter_screenutil`.
* **Git Feature Branch Workflow**: Developed using isolated feature branches to ensure clean code integration, stable releases, and efficient version control.

---

## 🛠 Tech Stack & Architecture

* **Framework**: [Flutter](https://flutter.dev/) (Dart)
* **Architecture**: Clean Architecture (Data, Domain, Presentation)
* **State Management**: `flutter_bloc` / `cubit`
* **Network & REST API**: `dio`
* **Network Checking**: `internet_connection_checker_plus`
* **Dependency Injection**: `get_it`
* **Local Storage**: `shared_preferences` 
* **Screen Responsiveness**: `flutter_screenutil`
* **Version Control**: Git (Feature Branch Workflow)

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
│   ├── search/          # Search feature (Dynamic filtering & queries)
│   └── home/            # Main dashboard, tasks management & reactive UI logic
└── main.dart            # Entry point & app setup
