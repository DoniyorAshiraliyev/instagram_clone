import 'package:flutter/material.dart';
import 'package:instagram_clone/domain/model/member_model.dart';
import 'package:instagram_clone/presentation/pages/screens/auth/signin_page.dart';
import 'package:instagram_clone/services/auth_service.dart';
import 'package:instagram_clone/services/db_service.dart';
import 'package:instagram_clone/services/utils_service.dart';

import '../main/home_page.dart';


class SignUpPage extends StatefulWidget {
  static const String id = "signup_page";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _doSignUp() async{
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) return;

    if (cpassword != password) {
      Utils.fireToast("Password and confirm password does not match");
      return;
    }
    setState(() {
      isLoading = true;
    });
    var response = await AuthService.signUpUser(fullname, email, password);
    Member member = Member(fullname, email);
    DBService.storeMember(member).then((value) => {
      storeMemberToDB(member),
    });
  }

  void storeMemberToDB(Member member) {
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  _callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(193, 53, 132, 1),
                  Color.fromRGBO(131, 58, 180, 1),
                ]),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Instagram",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontFamily: "Billabong"),
                          ),

                          //#fullname
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)),
                            child: TextField(
                              controller: fullnameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "Fullname",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 17, color: Colors.white54)),
                            ),
                          ),

                          //#email
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)),
                            child: TextField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 17, color: Colors.white54)),
                            ),
                          ),

                          //#password
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "Password",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 17, color: Colors.white54)),
                            ),
                          ),

                          //#cpassword
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7)),
                            child: TextField(
                              controller: cpasswordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  hintText: "Confirm Password",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 17, color: Colors.white54)),
                            ),
                          ),

                          //#signin
                          GestureDetector(
                            onTap: () {
                              _doSignUp();
                            },
                            child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                height: 50,
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(7)),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                )),
                          ),
                        ],
                      )),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              _callSignInPage();
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }
}