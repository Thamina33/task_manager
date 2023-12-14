import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/auth_controller.dart';
import '../widget/body_background.dart';
import '../widget/snack_message.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otp;
  final String email;
  const ResetPasswordScreen({super.key , required this.email , required this.otp});



  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var resetPassProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Set Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Minimum password length should be more than 8 letters',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _passTEController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12,),
                    TextFormField(
                      controller: _confirmPassTEController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter Confirm password';
                        }
                        if (value!.length < 6) {
                          return 'Enter password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: resetPassProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              var pass = _passTEController.text.toString();
                              var conPass = _confirmPassTEController.text.toString();
                              if(pass == conPass){
                                resetPass();
                              }
                              else{
                                showSnackMessage(context, "Password and confirm Password doesn't match");
                              }

                            }

                          },
                          child: const Text('Confirm'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAll(const LoginScreen());
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPass() async {
     resetPassProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.recoverResetPass, body: {
      'email' : widget.email,
      'OTP' : widget.otp,
      'password' : _passTEController.text.toString(),
    });
     resetPassProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.jsonResponse["status"]=='success') {

      if (mounted) {
        showSnackMessage(context , "Password has been Changed, Please Login", true);
        Get.to(const LoginScreen());
      }
    }
    else {
      if (mounted) {
        showSnackMessage(context, response.jsonResponse["data"].toString(), true);
      }
    }
  }

  @override
  void dispose() {
    _passTEController.dispose();
    _confirmPassTEController.dispose();
    super.dispose();
  }
}