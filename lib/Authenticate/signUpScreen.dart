import 'package:chat_application/Authenticate/loginScreen.dart';
import 'package:chat_application/Authenticate/methods.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/signUpBG.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.width / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: size.height / 15,
                  ),
                  Container(
                    width: size.width - 25,
                    alignment: Alignment.topRight,
                    child: Column(
                      children: const [
                        Text(
                          "SNAPY",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "SNAP",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 9,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: const [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "please enter in down below",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  field(
                      size,
                      "Enter Email",
                      const Icon(Icons.email_rounded, color: Colors.white),
                      _email),
                  const SizedBox(height: 10),
                  field(
                      size,
                      "Enter Full Name",
                      const Icon(Icons.account_box_rounded,
                          color: Colors.white),
                      _name),
                  const SizedBox(height: 10),
                  field(
                      size,
                      "Enter UserName",
                      const Icon(Icons.perm_identity_rounded,
                          color: Colors.white),
                      _userName),
                  const SizedBox(height: 10),
                  field(size, "Enter Password",
                      const Icon(Icons.lock, color: Colors.white), _pass),
                  const SizedBox(height: 10),
                  field(size, "Confirm Password",
                      const Icon(Icons.lock, color: Colors.white), _pass),
                  const SizedBox(height: 20),
                  customButton(size, "Sign Up"),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account? ',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height / 30),
                  Column(
                    children: const [
                      Text(
                        "We need permissions for the service you use",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        'Learn More',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ]),
              ),
      ),
    );
  }

  Widget customButton(Size size, String text) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _userName.text.isNotEmpty &&
            _pass.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          createAccount(_name.text, _email.text, _pass.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              print("Account created");
            } else {
              setState(() {
                isLoading = false;
              });
              print("Failed");
            }
          });
        } else {
          print("Enter all fields");
        }
      },
      child: Container(
        height: size.height / 22,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          color: const Color(0xffc8c8c8).withOpacity(0.40),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget field(
    Size size, String hintText, Icon icon, TextEditingController cont) {
  return SizedBox(
    height: size.height / 15,
    width: size.width / 1.2,
    child: TextField(
      style: TextStyle(color: Colors.white),
      controller: cont,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
