import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/pages/home.dart';
import 'package:projectapp/pages/mainscreen.dart';

class FeedbackPage extends StatelessWidget {
  final Set<String> selectedGenres;

  FeedbackPage({required this.selectedGenres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(243, 163, 197, 1), // Lighter complementary shade
              Color.fromRGBO(88, 11, 56, 1.0), // Primary color
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text('Thank you for selecting your favorite genres! ',
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(252, 228, 242, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.w800)),
              ),
              SizedBox(height: 10),
              Text('You have chosen the following genres:',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 20),
              Expanded(
                child: selectedGenres.isEmpty
                    ? Center(
                        child: Text(
                          'No genres selected. Please go back and choose at least one genre.',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: selectedGenres.length,
                        itemBuilder: (context, index) {
                          final genre = selectedGenres.elementAt(index);
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.bookmark_added,
                                color: Color.fromRGBO(88, 11, 56, 1.0),
                              ),
                              title: Text(genre,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(88, 11, 56, 1.0))),
                            ),
                          );
                        },
                      ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: Text('Enjoy Your Journey💗! ',
                      style: GoogleFonts.poppins(
                          color: Color.fromRGBO(252, 228, 242, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.w800)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                          selectedGenres:
                              selectedGenres), // Pass selected genres
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(243, 163, 197, 1),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Done',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
