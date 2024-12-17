import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/pages/signup.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(163, 42, 59, 1)),
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
              width: 10,
              child: Padding(
                padding: EdgeInsets.only(left: 23, right: 23),
                child: TextField(
                  cursorColor: Color.fromRGBO(163, 42, 59, 1),
                  decoration: InputDecoration(
                      hintText: 'Username',
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(163, 42, 59, 1), width: 3)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(
              height: 50,
              width: 10,
              child: Padding(
                padding: EdgeInsets.only(left: 23, right: 23),
                child: TextField(
                  cursorColor: Color.fromRGBO(163, 42, 59, 1),
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(163, 42, 59, 1), width: 3)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: Text(
                    'forgot your password?',
                    style: GoogleFonts.poppins(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(163, 42, 59, 1),
                    padding: const EdgeInsets.all(25),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(child: Text("Don't have an account?")),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signup()));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.black),
              child: const Text('Sign up'),
            )
          ],
        ),
      ),
    );
  }
}
