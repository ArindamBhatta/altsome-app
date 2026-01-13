import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../firebase_options.dart';

class ServiceInit {
  static final Logger _logger = Logger();

  static Future<void> init() async {
    try {
      _logger.i("Initializing Firebase...");

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Emulator setup
      if (kDebugMode) {
        try {
          _logger.i("Setting up Firebase Emulators...");
          // Android emulator 10.0.2.2, iOS/Web localhost
          const String host = '10.0.2.2'; // Optimized for Android Emulator

          await FirebaseAuth.instance.useAuthEmulator(host, 9099);
          FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
          await FirebaseStorage.instance.useStorageEmulator(host, 9199);

          _logger.i("Firebase Emulators configured correctly.");
        } catch (e) {
          _logger.e("Failed to setup emulators: $e");
        }
      }

      _logger.i("Firebase initialized successfully.");
    } catch (e) {
      _logger.e("Error initializing services", error: e);
      // In production, you might want to rethrow or handle gracefully.
      // For now, allowing app to proceed (maybe offline mode?)
    }
  }
}
