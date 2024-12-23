import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/pages/selectedGenresFeedback.dart';

class GenreSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GenreSelectionPage(),
    );
  }
}

class GenreSelectionPage extends StatefulWidget {
  @override
  _GenreSelectionPageState createState() => _GenreSelectionPageState();
}

class _GenreSelectionPageState extends State<GenreSelectionPage> {
  final List<String> genres = [
    'Romance',
    'Science Fiction',
    'Mystery',
    'Fantasy',
    'Humor',
    'Non-fiction',
    'Horror',
    'Historical',
    'Biography'
  ];

  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(88, 11, 56, 1.0), // Primary color
              Color.fromRGBO(243, 163, 197, 1), // Lighter complementary shade
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('What would you like to read today ?',
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(252, 228, 242, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.w800)),
                Text(
                  'Select the type of books you enjoy reading.',
                  style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      final genre = genres[index];
                      final isSelected = selectedGenres.contains(genre);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedGenres.remove(genre);
                            } else {
                              selectedGenres.add(genre);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color.fromRGBO(88, 11, 56, 1.0)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 5,
                              color: isSelected
                                  ? Color.fromRGBO(88, 11, 56, 1.0)
                                  : Color.fromRGBO(88, 11, 56, 1.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              genre,
                              style: GoogleFonts.poppins(
                                  color: isSelected
                                      ? Colors.white
                                      : Color.fromRGBO(88, 11, 56, 1.0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed:
                        selectedGenres.isEmpty || selectedGenres.length < 2
                            ? null // Disable button if no genre is selected
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FeedbackPage(
                                      selectedGenres: selectedGenres,
                                    ),
                                  ),
                                );
                              },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
