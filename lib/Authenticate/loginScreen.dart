import 'package:chat_application/Authenticate/signUpScreen.dart';
import 'package:chat_application/Authenticate/methods.dart';
import 'package:chat_application/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/loginBG.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height / 20,
                  width: size.width / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: size.height / 12),
                    //snapy-snap container
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          Text(
                            "SNAPY",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "SNAP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height / 2.2),
                    field(
                        size,
                        "Enter Email",
                        const Icon(Icons.email_outlined, color: Colors.white),
                        _email),
                    const SizedBox(height: 10),
                    field(
                        size,
                        "Enter Password",
                        const Icon(Icons.lock_outline_rounded,
                            color: Colors.white),
                        _pass),
                    const SizedBox(height: 15),
                    customButton(size, "Log In"),

                    SizedBox(height: size.height / 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign Up',
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
                  ],
                ),
              ),
      ),
    );
  }

  Widget customButton(Size size, String text) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _pass.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          logIn(_email.text, _pass.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              print('Logged In');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              setState(() {
                isLoading = false;
              });
              print("failed");
            }
          });
        } else {
          print("Enter every fields");
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
