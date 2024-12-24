import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';

class DrawerMenu extends StatelessWidget {
  final String? username;
  final String? email;
  final Set<String> selectedGenres;

  const DrawerMenu(
      {Key? key, this.username, this.email, required this.selectedGenres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: username != null ? Text(username!) : null,
            accountEmail: email != null ? Text(email!) : null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Color.fromRGBO(88, 11, 56, 1.0),
                size: 40,
              ),
            ),
            decoration:
                const BoxDecoration(color: Color.fromRGBO(88, 11, 56, 1.0)),
          ),
          if (username == null && email == null) ...[
            ListTile(
              title: const Text('Login'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(
                            selectedGenres: selectedGenres,
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Sign Up'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Signup(selectedGenres: selectedGenres)),
                );
              },
            ),
          ] else ...[
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(selectedGenres: selectedGenres)),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
