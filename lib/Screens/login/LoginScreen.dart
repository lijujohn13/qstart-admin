import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/loginController.dart';
import '../../helpers/inputBox.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final ctrl = Get.put(loginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              //first container holds image
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                  'assets/images/login.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              //secont container holds inputboxes
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.grey[100],
                child: Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 97, 85, 85),
                            spreadRadius: 0.7,
                            blurRadius: 15,
                          )
                        ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                //email id
                                TextFormField(
                                  controller: ctrl.loginemail,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration:
                                      inputBoxes().maininputDecoration.copyWith(
                                          prefixIcon: const Icon(
                                            Icons.email,
                                          ),
                                          label: const Text('Email ')),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //password
                                Obx(
                                  () => TextFormField(
                                    controller: ctrl.loginpass,
                                    // _obscureText hold a bool value which tell hide or show password
                                    obscureText: ctrl.obscurePassSignin.value,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          const Icon(Icons.lock_outline),
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      label: const Text('Password'),
                                      //hide and show button on password field
                                      suffixIcon: IconButton(
                                        icon: Icon(ctrl.obscurePassSignin.value
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          // obs() {
                                          ctrl.obscurePassSignin.value =
                                              !ctrl.obscurePassSignin.value;

                                          // }
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                //forget password
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          popUpBox(context);
                                        },
                                        child: const Text('forget password')),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //sign In button
                                GestureDetector(
                                  onTap: () {
                                    ctrl.signin();
                                  },
                                  child: Obx(
                                    () => Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 39, 183, 240),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: (ctrl.status.value == true)
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : const Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //popup
  Future popUpBox(BuildContext ctx) async {
    return showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            content: Container(
              width: 300,
              height: 250,
              padding: EdgeInsets.all(11),
              color: Colors.white,
              child: ListView(children: [
                Center(
                    child: Text('Forgot Password',
                        style: GoogleFonts.poppins(fontSize: 30))),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: ctrl.resetEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputBoxes().maininputDecoration.copyWith(
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      label: const Text('Email Id')),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    ctrl.resetpassword();
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 39, 183, 240),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                        child: Text(
                      'Send Reset Link',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Close'))
              ]),
            ),
          );
        });
  }
}
