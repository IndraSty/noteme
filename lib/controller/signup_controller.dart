import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteme/authentication/authentication_controller.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final fullname = TextEditingController();

  ValueNotifier<String> genderNotifier = ValueNotifier<String>('Male');

  void registerUser(
      String email, String password, String fullname, String gender) {
    AuthenticationController.instance
        .createUserWithEmailAndPassword(email, password, fullname, gender);
  }
}

class SignUpUserWithEmailAndPasswordFailure {
  final String message;

  const SignUpUserWithEmailAndPasswordFailure(
      [this.message = "An Unknown error occurred."]);

  factory SignUpUserWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpUserWithEmailAndPasswordFailure(
            'Please enter a stronger password!');
      case 'invalid-email':
        return const SignUpUserWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted!');
      case 'email-already-in-use':
        return const SignUpUserWithEmailAndPasswordFailure(
            'An account already exist for that email!');
      case 'operation-not-allowed':
        return const SignUpUserWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support!');
      case 'user-disabled':
        return const SignUpUserWithEmailAndPasswordFailure(
            'This user has been disabled. Please contact support for help!');
      default:
        return const SignUpUserWithEmailAndPasswordFailure();
    }
  }
}
