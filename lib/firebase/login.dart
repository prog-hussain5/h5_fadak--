// ignore_for_file: non_constant_identifier_names, camel_case_types, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
///////////////////////////////////////////////////////

  final  _email = TextEditingController();
  final _password = TextEditingController();
    bool _obscureText = true;

  Future login() async {
    if (check_enter_user()) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _password.text.trim());
      Navigator.of(context).pushNamed("/");
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 300,
              width: double.infinity,
              child: Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        "لم تقم باضافه البريد الالكتروني او كلمة المرور حاول مجددا ",
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[500])),
                  ),
                ),
              ),
            );
          });
    }
  }

  bool check_enter_user() {
    if (_email.text.trim() != "" && _password.text.trim() != "") {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void go_to_signUp() {
    Navigator.of(context).pushReplacementNamed("sinUp_screens");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              //image
              Image.asset(
                "images/ibtikar.JPG",
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 10,
              ),
              //title
              Center(
                child: Text("Login ",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[500])),
              ),
              //subtitle
              Center(
                child: Text("Welcome, nice to see you :)",
                    style: GoogleFonts.robotoCondensed(fontSize: 20)),
              ),
              const SizedBox(
                height: 40,
              ),
              //email textfild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "E-mail"),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //password textfild
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _password,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                    ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // sign in botton
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InkWell(
                  // مثل الانكويلي
                  onTap: login,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[600],
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      "Login",
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // text  to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you do not have a previous account",
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: go_to_signUp,
                    child: Text("Create a new account",
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.deepPurple[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
