import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:projectapp/pages/sqlit.dart';
import 'home.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  final Set<String> selectedGenres;

  const Signup({Key? key, required this.selectedGenres}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final SqlDb _sqlDb = SqlDb();

  // void _signup() async {
  //   final name = _nameController.text;
  //   final email = _emailController.text;
  //   final password = _passwordController.text;
  //   final confirmPassword = _confirmPasswordController.text;

  //   if (name.isEmpty ||
  //       email.isEmpty ||
  //       password.isEmpty ||
  //       confirmPassword.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill in all fields')),
  //     );
  //     return;
  //   }

  //   if (password != confirmPassword) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Passwords do not match')),
  //     );
  //     return;
  //   }

  //   bool exists = await _sqlDb.emailExists(email);
  //   if (exists) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Email already exists')),
  //     );
  //     return;
  //   }

  //   final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
  //   await _sqlDb.insertData({
  //     'name': name,
  //     'email': email,
  //     'password': hashedPassword,
  //   });

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => HomeScreen(
  //               username: name,
  //               email: email,
  //               selectedGenres: widget.selectedGenres,
  //             )),
  //   );
  // }
  void _signup() async {
    print('Sign-up process started');

    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      print('Empty fields detected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      print('Passwords do not match');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    bool exists = await _sqlDb.emailExists(email);
    print('Email exists check result: $exists');
    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email already exists')),
      );
      return;
    }

    final hashedPassword = await BCrypt.hashpw(password, BCrypt.gensalt());
    print('Password hashed successfully');
    await _sqlDb.insertData({
      'name': name,
      'email': email,
      'password': hashedPassword,
    });
    print('User data inserted');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(
          selectedGenres: widget.selectedGenres,
        ),
      ),
    );
    print('Navigation to HomeScreen initiated');
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
                    'Create Account',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(163, 42, 59, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Name', _nameController, false, Icons.person),
              const SizedBox(height: 20),
              _buildTextField('Email', _emailController, false, Icons.email),
              const SizedBox(height: 20),
              _buildTextField(
                  'Password', _passwordController, true, Icons.lock),
              const SizedBox(height: 20),
              _buildTextField('Confirm Password', _confirmPasswordController,
                  true, Icons.lock_outline),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(163, 42, 59, 1),
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                selectedGenres: widget.selectedGenres,
                              )),
                    );
                  },
                  child: Text(
                    'Already have an account? Log In',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromRGBO(163, 42, 59, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      bool isPassword, IconData icon) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color.fromRGBO(163, 42, 59, 1)),
      ),
    );
  }
}
