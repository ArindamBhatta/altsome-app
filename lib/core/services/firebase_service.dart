import 'package:altsome_app/core/utils/app_logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';

class FirebaseService {
  static Future<void> init() async {
    try {
      AppLogger.logger.i("Initializing Firebase...");

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Emulator setup
      if (kDebugMode) {
        try {
          AppLogger.logger.i("Setting up Firebase Emulators...");
          // Android emulator 10.0.2.2, iOS/Web localhost
          const String host = '10.0.2.2'; // Optimized for Android Emulator

          await FirebaseAuth.instance.useAuthEmulator(host, 9099);
          FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
          await FirebaseStorage.instance.useStorageEmulator(host, 9199);

          AppLogger.logger.i("Firebase Emulators configured correctly.");
        } catch (e) {
          AppLogger.logger.e("Failed to setup emulators: $e");
        }
      }
      AppLogger.logger.i("Firebase initialized successfully.");
    } catch (error) {
      AppLogger.logger.e("Error initializing services", error: error);
      rethrow;
    }
  }
}
