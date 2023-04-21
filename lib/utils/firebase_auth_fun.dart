import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_just_for_fun/utils/constant.dart';

class FirebaseAuthFunc {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<Map<String, dynamic>> phoneFirebaseAuth(
      String phoneNumber) async {
    Map<String, dynamic> data = {};
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: '$COUNTY_PHONE $phoneNumber',
          verificationCompleted: (PhoneAuthCredential credential) async {
            //not using
          },
          verificationFailed: (FirebaseAuthException error) {},
          codeSent: (String verificationId, int? forceResendingToken) {
            data['verificationId'] = verificationId;
            data['forceResendingToken'] = forceResendingToken;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print(
                "function codeAutoRetrievalTimeOut : verifycationId - $verificationId");
          });
    } catch (e) {
      print(e);
    }
    return data;
  }

  static Future<void> verifyFirebaseAuth(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    await auth.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        print("smscode: ${credential.smsCode}");
      }
    });
  }
}
//AHTqx5bzpmlAtAfshnqaniQ4_jL4UHP9YL_asaKZXyC5tO1cfoTY_IasWyKiUwwTaYc0hBpS5nYa4XGPFU9yG-nyNBbvdmD6ct_qHkQd4HuUMSwA3th55MCbnmblWdk7lwwpxjG8sELXv89KY5dpJbCLQfwuYKazzg
//HTqx5Y_G2XL-juKKaque0hCVRama1hNbHqacDSEEQ-PoVtwBVdfu2gFVpkDjtLOgwtzqdkALjh0m6ODN20sf-8cX3cDmlrJ9bnsSGJAR048-7ZT48jcmf1cgRYLfrG2JY5z4pRo8eDDv2s3wgDM5GmgOYmUyVCBTg
//AHTqx5YKbRjM58dnxCYMemLeZkp63gu20NJUzn1gEbiitgtXe-LFPSr0XMv7AVRyFvCSEc_J4fXTdj6a7sATuFxRzhWHlVxoNYjFOAeT7_Nlv6drGsv0GRKQ6aU7GZyOAr2AD83CGStfohiGuNJtmKUyRZt_6I9PCA || forceResendingToken - 42046428
