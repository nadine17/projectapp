import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectapp/models/book.dart';
import 'package:projectapp/pages/bookDetails.dart';
import 'package:projectapp/pages/drawer.dart';
import 'package:projectapp/pages/geners.dart';
import 'package:projectapp/pages/myLibrary.dart';
import 'package:projectapp/pages/quiz.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'BookVibe',
            style: GoogleFonts.poppins(
                color: Color.fromRGBO(88, 11, 56, 1.0),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Color.fromRGBO(88, 11, 56, 1.0),
              size: 24,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color.fromRGBO(88, 11, 56, 1.0),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLibraryPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: '',
          ),
        ],
      ),
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
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Get unlimited access to books in just a moment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '*Terms & conditions apply',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Image.network(
                        'https://www.free-ebooks.net/2d_covers/large/1573321793.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Section(
                title: 'Recommended for you',
                books: filteredBooks,
              ),
              const SizedBox(height: 20),
              Section(
                title: 'Explore other books',
                books: shuffledBooks,
                isGrid: true, // Pass the isGrid flag to show books in grid
              ),
              const SizedBox(height: 20),
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(88, 11, 56, 1.0),
          ),
        ),
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
                        const SizedBox(height: 8),
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.author,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              )
            : SizedBox(
                height: 200,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                book.coverImageUrl,
                                height: 150,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${book.author}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
