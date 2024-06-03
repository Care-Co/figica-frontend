import 'package:firebase_auth/firebase_auth.dart';
import 'package:fisica/index.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 회원 탈퇴 함수
  Future<void> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        print("회원 탈퇴가 완료되었습니다.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print("최근 로그인 후 다시 시도해 주세요.");
      } else {
        print("회원 탈퇴 중 오류가 발생했습니다: ${e.message}");
      }
    }
  }

  Future resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message!}')),
      );
      return null;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset email sent')),
    );
  }

  Future<void> sendSmsCode(String phoneNumber, bool setinfo, VoidCallback onCodeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          print("SMS 인증 실패: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          print(verificationId);
          AppStateNotifier.instance.verificationId({'setinfo': setinfo, 'phone': phoneNumber, 'verificationId': verificationId});
          onCodeSent();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("SMS 코드 전송 중 오류가 발생했습니다: $e");
    }
  }

  // SMS 코드 확인 함수
  Future<void> verifySmsCode(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        print("SMS 코드 인증이 완료되었습니다.");
      }
    } catch (e) {
      print("SMS 코드 인증 중 오류가 발생했습니다: $e");
    }
  }
}
