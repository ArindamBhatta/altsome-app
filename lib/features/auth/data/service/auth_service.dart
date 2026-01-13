import 'dart:async';
import 'dart:convert';

import 'package:altsome_app/utils/globals.dart';
import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static final StreamController<Map<String, dynamic>?> _streamController =
      StreamController<Map<String, dynamic>?>.broadcast();

  static Stream<Map<String, dynamic>?> get stream => _streamController.stream;

  static void init() {
    _googleSignIn.authenticationEvents.listen((event) {
      if (event is GoogleSignInAuthenticationEventSignIn) {
        _handleGoogleSignIn(event.user);
      } else if (event is GoogleSignInAuthenticationEventSignOut) {
        FirebaseAuth.instance.signOut();
      }
    });

    // Attempt silent sign-in on app start
    _googleSignIn.attemptLightweightAuthentication();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _streamController.add({
          'id': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'photoUrl': user.photoURL,
        });
      } else {
        _streamController.add(null);
      }
    });
  }

  static Future<void> _handleGoogleSignIn(GoogleSignInAccount user) async {
    try {
      final GoogleSignInAuthentication gAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
      );

      UserCredential firebaseUserData =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String? uid = firebaseUserData.user?.uid;
      if (uid == null) return;

      DocumentSnapshot<Map<String, dynamic>> existingUserData =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (!existingUserData.exists) {
        Map<String, dynamic> configData = await AuthService.getPointsConfig();

        await FirebaseFirestore.instance.collection('Users').doc(uid).set(
          {
            'userId': uid,
            'name': user.displayName,
            'userName': user.displayName?.replaceAll(' ', '').toCamelCase(),
            'email': user.email,
            'avatarImage': user.photoUrl,
            'cryptoWalletCoins': 0,
            'totalPoints':
                configData['status'] == true ? configData['signupBonus'] : 0,
            'dailyClaimedPoints': [],
            'lastClaimedData': {},
            'emailVerified': true,
          },
        );
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', uid);
      Globals.userId = uid;
      prefs.setString('emailVerified', 'true');
      Globals.isEmailVerified = true;
    } catch (e) {
      debugPrint('Error handling Google Sign In: $e');
    }
  }

  // --------------------------------------------
  static Future<Map<String, dynamic>> authenticate(
      String userId, String password) async {
    UserCredential? firebaseUserData;
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      firebaseUserData = await auth.signInWithEmailAndPassword(
        email: userId,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', firebaseUserData.user!.uid);
      Globals.userId = firebaseUserData.user!.uid;
      prefs.setString(
          'emailVerified', firebaseUserData.user!.emailVerified.toString());
      Globals.isEmailVerified = firebaseUserData.user!.emailVerified;

      return {
        'status': true,
        'data': firebaseUserData.user!.uid,
      };
    } on FirebaseAuthException catch (e) {
      return {'status': false, 'message': e.message};
    }
  }

  static Future<dynamic> getSharedPreferenceData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId;
    String? isEmailVerified;
    bool isLoggedIn = prefs.containsKey('userId');

    if (isLoggedIn) {
      userId = prefs.getString('userId')!;
      isEmailVerified = prefs.getString('emailVerified');
      Globals.userId = userId;
      Globals.isEmailVerified = isEmailVerified == 'true' ? true : false;
      return userId;
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> getProfileData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(userId)
          .get();

      if (!userData.exists) {
        return {'status': false, 'message': 'User profile not found.'};
      }

      UserModel user =
          UserModel.fromJson(userData.data() as Map<String, dynamic>);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', user.userName);
      prefs.setString('name', user.name);
      return {'status': true, 'data': user};
    } on FirebaseException catch (e) {
      return {'status': false, 'message': e.message};
    }
  }

  static Future<bool> isUsernameAvailable(String username) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('userName', isEqualTo: username)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> isEmailAvailable(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isEmpty;
    } catch (error) {
      return false;
    }
  }

  static Future<Map<String, dynamic>> getPointsConfig() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('Configs')
          .doc('points')
          .get();

      return {'status': true, 'signupBonus': doc.data()?['signup-bonus'] ?? 0};
    } on FirebaseException catch (e) {
      return {'status': false, 'message': e.message};
    }
  }

  static Future<Map<String, dynamic>> register(
      Map<String, dynamic> userProfileData) async {
    UserCredential? firebaseUserData;

    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      //Create Account
      firebaseUserData = await auth.createUserWithEmailAndPassword(
          email: userProfileData['email']!,
          password: userProfileData['password']!);

      //Create Firestore Users document
      String uid = firebaseUserData.user!.uid;
      Globals.userId = uid;
      try {
        final CollectionReference collectionRef =
            FirebaseFirestore.instance.collection('Users');
        await collectionRef.doc(uid).set(
          {
            'userId': uid,
            'name': userProfileData['name'],
            'userName': userProfileData['userName'],
            'email': userProfileData['email'],
            'cryptoWalletCoins': 0,
            // points related data
            'totalPoints': userProfileData['signupBonus'] ?? 0,
            'dailyClaimedPoints': [],
            'lastClaimedData': {},
            'emailVerified': false,
          },
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', userProfileData['userName']!);
        prefs.setString('name', '${userProfileData['name']}');
        prefs.setString('userId', uid);
      } on FirebaseException catch (e) {
        return {'status': false, 'message': e.message, 'data': ''};
      }

      return {'status': true, 'message': '', 'data': uid};
    } on FirebaseAuthException catch (e) {
      return {'status': false, 'message': e.message, 'data': null};
    }
  }

  static Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return {'status': true, 'message': ''};
    } on FirebaseAuthException catch (e) {
      return {'status': false, 'message': e.message};
    }
  }

  static eraseLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? settings = prefs.getString('notificationSettings');
    if (settings != null) {
      List notificationTopics = jsonDecode(settings);
      try {
        for (var topics in notificationTopics) {
          await FirebaseMessaging.instance.unsubscribeFromTopic(topics['id']);
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    Globals.userId = null;
    Globals.fcmToken = null;
    Globals.apiUserId = 'Anonymous';
    Globals.isEmailVerified = false;
    Globals.isPortfolioAddeed = false;
    Globals.isNotificationOpen = false;
    await prefs.clear();
  }

  static Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      if (await _googleSignIn.supportsAuthenticate()) {
        await _googleSignIn.authenticate();
        return {'status': true, 'message': 'Authentication started.'};
      } else {
        // Fallback or direct signIn()
        //await _googleSignIn.signIn();
        return {'status': true, 'message': 'Sign-in started.'};
      }
    } catch (e) {
      return {'status': false, 'message': e.toString()};
    }
  }

  static Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
