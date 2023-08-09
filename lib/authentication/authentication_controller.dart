import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:noteme/controller/signup_controller.dart';
import 'package:noteme/screens/bot_navbar.dart';
import 'package:noteme/screens/welcome_screen.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find();

  //variables
  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialScreen);
    super.onReady();
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => const BottomNavbarScreen(
              selectedIndex: 0,
            ));
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String fullname, String gender) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String docId = email;
      await FirebaseFirestore.instance.collection('users').doc(docId).set({
        'fullname': fullname,
        'email': email,
        'gender': gender,
      });
      final firebaseUser = auth.currentUser;
      if (firebaseUser != null) {
        Get.offAll(() => const BottomNavbarScreen(
              selectedIndex: 0,
            ));
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      print('FIREBASE AUTH EXCEPTION - ${e.message}');
      // Lakukan tindakan yang sesuai tergantung pada jenis pengecualian
    } on SignUpUserWithEmailAndPasswordFailure catch (ex) {
      print('EXCEPTION - ${ex.message}');
      // Lakukan tindakan yang sesuai tergantung pada jenis pengecualian
    }
    // try {
    //   await auth.createUserWithEmailAndPassword(
    //       email: email, password: password);
    //   firebaseUser.value != null
    //       ? Get.offAll(() => const HomePage())
    //       : Get.offAll(() => const SignUpScreen());
    // } on FirebaseAuthException catch (e) {
    //   final ex = SignUpUserWithEmailAndPasswordFailure.code(e.code);
    //   print('FIREBASE AUTH EXCEPTION - ${ex.message}');
    //   throw ex;
    // } catch (_) {
    //   const ex = SignUpUserWithEmailAndPasswordFailure();
    //   print('EXCEPTION - ${ex.message}');
    //   throw ex;
    // }
  }

  Future<void> signinUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logout() async => await auth.signOut();
}
