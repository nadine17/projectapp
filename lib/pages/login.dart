import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/pages/mainscreen.dart';
import 'package:projectapp/pages/sqlit.dart';
import 'package:bcrypt/bcrypt.dart';
import 'home.dart'; // Import your Home screen
import 'signup.dart'; // Import your Signup screen

class Login extends StatefulWidget {
  final Set<String> selectedGenres;

  const Login({Key? key, required this.selectedGenres}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SqlDb _sqlDb = SqlDb();
  bool _isLoading = false;

  // Function to handle login
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Debug print
      print('Attempting login with email: $email');

      final users = await _sqlDb.getUserByEmail(email);
      print('Attempting login with users: $users');
      // If no user is found
      if (users.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final storedPassword = users[0]['password'];
      if (storedPassword == null || !BCrypt.checkpw(password, storedPassword)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // If everything is correct, navigate to home
      print('Login successful');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            selectedGenres: widget.selectedGenres,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred, please try again later')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
                child: Center(
                  child: Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(163, 42, 59, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Email input field
              _buildTextField('Email', _emailController, false, Icons.email),
              const SizedBox(height: 20),
              // Password input field
              _buildTextField(
                  'Password', _passwordController, true, Icons.lock),
              const SizedBox(height: 30),
              // Login button
              ElevatedButton(
                onPressed:
                    _isLoading ? null : _login, // Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 42, 59, 1),
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white) // Show loading indicator
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
              ),
              const SizedBox(height: 20),
              // Redirect to Signup page if the user doesn't have an account
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigate directly to the Signup page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Signup(
                                selectedGenres: widget.selectedGenres,
                              )), // Signup screen page
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromRGBO(163, 42, 59, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for text fields
  Widget _buildTextField(String hint, TextEditingController controller,
      bool isPassword, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: const Color.fromRGBO(163, 42, 59, 1),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color.fromRGBO(163, 42, 59, 1)),
        filled: true,
        fillColor: const Color.fromARGB(255, 245, 245, 245),
        contentPadding: const EdgeInsets.all(18),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromRGBO(163, 42, 59, 1),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 200, 200, 200), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
