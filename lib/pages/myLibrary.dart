import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/global.dart';
import 'package:projectapp/pages/bookDetails.dart';

class MyLibraryPage extends StatefulWidget {
  @override
  _MyLibraryPageState createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  // Create a map to store random times for each book
  final Map<int, int> bookTimes = {};

  // Function to generate random minutes
  int generateRandomMinutes() {
    return Random().nextInt(20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My Library',
          style: GoogleFonts.poppins(
              color: Color.fromRGBO(88, 11, 56, 1.0),
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: savedBooks.isEmpty
          ? Center(
              child: Text(
                'No books saved yet.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(13),
              child: GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: savedBooks.length,
                itemBuilder: (context, index) {
                  final book = savedBooks[index];

                  // If this book hasn't been assigned a random time, generate one
                  if (!bookTimes.containsKey(index)) {
                    bookTimes[index] = generateRandomMinutes();
                  }

                  int randomMinutes = bookTimes[index]!;

                  return GestureDetector(
                    onTap: () {
                      // Navigate to the Bookdetails page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Bookdetails(book: book),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  book.coverImageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              book.author,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.timer, size: 14, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  "$randomMinutes mins",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.white)),
                            icon: Icon(Icons.bookmark_remove_outlined,
                                color: Colors.red),
                            onPressed: () {
                              setState(() {
                                savedBooks.removeAt(index); // Remove book
                                bookTimes
                                    .remove(index); // Remove time for the book
                              });

                              // Show a confirmation message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green[500],
                                  content:
                                      Text('${book.title} has been removed!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
