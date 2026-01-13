# Altsome Clone

A cryptocurrency application built with Flutter, using Firebase for the backend and BLoC for state management.

## Architecture

This project follows a **Feature-First** architecture.

### Directory Structure

```
lib/
├── firebase_options.dart   # Firebase configuration
├── main.dart               # Entry point
├── config/
│   ├── routes.dart         # GoRouter configuration
│   └── theme.dart          # Theme configuration
├── core/
│   ├── widgets/            # Shared widgets
│   └── services/           # Core services (e.g., Firebase init)
└── features/
    ├── auth/               # Authentication Feature
    │   ├── bloc/           # AuthBloc / AuthCubit
    │   ├── data/           # AuthRepository
    │   └── presentation/   # Login/Signup Screens
    ├── home/               # Home Feature
    │   └── home_screen.dart
    ├── market/             # Market Feature
    └── feed/               # Social Feed Feature
```

## Setup & Running

### Prerequisites

- Flutter SDK
- Firebase CLI (for Emulator)

### Running Locally with Firebase Emulator

1.  Start the Firebase Emulators:
    ```bash
    firebase emulators:start
    ```
2.  Run the Flutter app:
    ```bash
    flutter run
    ```
    _Note: The app is configured to connect to `10.0.2.2` for Android emulators._

## State Management

- **BLoC/Cubit**: Used for all state management.
- **Equatable**: Used for value equality in States and Events.

## Backend

- **Firebase Auth**: Authentication.
- **Firestore**: Database.
- **Firebase Storage**: File storage.
