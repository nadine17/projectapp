import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/models/book.dart';
import 'package:projectapp/pages/bookDetails.dart';
import 'package:projectapp/pages/drawer.dart';
import 'package:projectapp/pages/geners.dart';
import 'package:projectapp/pages/myLibrary.dart';
import 'package:projectapp/pages/profile.dart';

import 'package:projectapp/pages/quiz.dart';
import 'package:projectapp/widgets/bookCard.dart';
import '../data/book_data.dart';

class HomeScreen extends StatelessWidget {
  final Set<String> selectedGenres;
  const HomeScreen({Key? key, required this.selectedGenres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books.where((book) {
      // Check if the book's category is in the selected genres
      return selectedGenres.contains(book.category);
    }).toList();

    final shuffledBooks = List<Book>.from(books);
    shuffledBooks.shuffle();

    final shuffledFilteredBooks = List<Book>.from(filteredBooks);
    shuffledFilteredBooks.shuffle();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        shadowColor: Colors.grey,
        title: Text(
          'BookVibe',
          style: GoogleFonts.poppins(
              color: Color.fromRGBO(88, 11, 56, 1.0),
              fontSize: 27,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(88, 11, 56, 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(88, 11, 56, 1.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Get unlimited access to books in just a moment',
                                            style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white)),
                                        const SizedBox(height: 4),
                                        const Text(
                                          '*Terms & conditions apply',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                115, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Container(
                                height: 90, // Adjust the height as needed
                                child: GridView.builder(
                                  physics:
                                      const NeverScrollableScrollPhysics(), // Prevents internal scrolling
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5, // Two items per row
                                    mainAxisSpacing:
                                        8, // Vertical spacing between rows
                                    crossAxisSpacing:
                                        8, // Horizontal spacing between items
                                    childAspectRatio:
                                        0.75, // Adjusts the height-to-width ratio
                                  ),
                                  itemCount: 5, // Number of book covers
                                  itemBuilder: (context, index) {
                                    final bookCoverUrl = [
                                      'https://www.free-ebooks.net/2d_covers/large/1722443761.jpg',
                                      'https://www.free-ebooks.net/2d_covers/large/1573321793.jpg',
                                      'https://www.free-ebooks.net/2d_covers/large/1714015010.jpg',
                                      'https://www.free-ebooks.net/2d_covers/large/1634818535.jpg',
                                      'https://www.free-ebooks.net/2d_covers/large/1586107172.jpg',
                                    ][index]; // Replace with dynamic URLs if available

                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        bookCoverUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Add more widgets below this if needed
                          ],
                        )),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CustomDivider(),
              Section(
                title: 'Recommended for you',
                books: shuffledFilteredBooks,
              ),
              const SizedBox(height: 20),
              const CustomDivider(),
              Section(
                title: 'Explore other books',
                books: shuffledBooks,
                isGrid: true, // Pass the isGrid flag to show books in grid
              ),
              const SizedBox(height: 20),
              const CustomDivider(),
              Section(
                title: 'Trending books',
                books: shuffledFilteredBooks,
              ),
              const SizedBox(height: 20),
              const GenresSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Book> books;
  final bool isGrid;

  const Section({
    Key? key,
    required this.title,
    required this.books,
    this.isGrid = false, // Default to false (list view)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(88, 11, 56, 1.0),
                fontSize: 20)),
        const SizedBox(height: 10),
        isGrid
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookCard(
                            title: book.title,
                            author: book.author,
                            coverUrl: book.coverImageUrl,
                            onTap: () {
                              // Navigate to the Bookdetails page when the card is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Bookdetails(book: book),
                                ),
                              );
                            },
                          ),
                        ],
                      ));
                },
              )
            : SizedBox(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
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
                      child: BookCard(
                        title: book.title,
                        author: book.author,
                        coverUrl: book.coverImageUrl,
                        onTap: () {
                          // Navigate to the Bookdetails page when the card is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Bookdetails(book: book),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(88, 11, 56, 1.0),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.star,
            color: Color.fromRGBO(88, 11, 56, 1.0),
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(88, 11, 56, 1.0),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
