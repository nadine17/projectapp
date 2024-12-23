import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/pages/home.dart';
import 'package:projectapp/pages/login.dart';
import 'package:projectapp/pages/myLibrary.dart';
import 'package:projectapp/pages/drawer.dart';
import 'package:projectapp/pages/profile.dart';
import 'package:projectapp/pages/signup.dart';
import 'package:projectapp/pages/splash.dart';
import 'package:projectapp/pages/timer.dart';

class MainScreen extends StatefulWidget {
  final Set<String> selectedGenres;

  const MainScreen({Key? key, required this.selectedGenres}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Widget getBody() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(selectedGenres: widget.selectedGenres);
      case 1:
        return HomeScreen(selectedGenres: widget.selectedGenres);
      case 2:
        return TimerPage();
      case 3:
        return MyLibraryPage();
      default:
        return HomeScreen(selectedGenres: widget.selectedGenres);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerMenu(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Color.fromRGBO(88, 11, 56, 1.0),
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.headphones),
              label: 'Audio books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Library',
            ),
          ],
        ),
        body: getBody());
  }
}
