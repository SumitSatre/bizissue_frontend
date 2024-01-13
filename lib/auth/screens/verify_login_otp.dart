import 'package:bizissue/auth/screens/controllers/login_provider.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOtp extends StatefulWidget {
  final String VerificationId;

  const MyOtp({Key? key, required this.VerificationId}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    var code = "";

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final loginController = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            loginController.cancelVerification();
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/img1.png",
                width: 150,
                height: 150,
                fit: BoxFit.fitHeight,
              ),

              SizedBox(
                height: 25,
              ),

              Text(
                "Phone Verification",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),

              SizedBox(
                height: 7,
              ),

              Text(
                "Register Now and Embark on Your Journey! 🚀",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: 20,
              ),

              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
                onChanged: (value){
                  code = value;
                },

              ),

              SizedBox(
                height: 25,
              ),

              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.VerificationId != null) {
                      try{
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.VerificationId, smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                        print("Done");

                        bool result = await loginController.verifyLoginOtp(context);

                        if(result){
                          GoRouter.of(context).goNamed(MyAppRouteConstants.homeRouteName);
                        }
                        else{
                          GoRouter.of(context).goNamed(MyAppRouteConstants.loginRouteName);
                          showSnackBar(context, "Otp verification failed!!", failureColor);
                        }

                      }
                      catch(err){
                          return showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("There is error, please try again!!"),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Ok")
                                    )
                                  ],
                                );
                              }
                          );
                      }
                    }
                    else {
                      // Handle the case where VerificationId is null
                      print("VerificationId is null");
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Verify otp"),
                ),
              ),

              SizedBox(height: 10,),

              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, 'phone');
                  },

                  child: Text("Edit phone number?" ,
                    style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.white),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
