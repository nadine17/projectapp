import 'package:flutter/material.dart';
import 'package:projectapp/global.dart';
import 'package:projectapp/models/book.dart';
import 'package:projectapp/pages/pdfViewer.dart';

class Bookdetails extends StatelessWidget {
  final Book book;

  const Bookdetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new, // Back arrow icon
              color: Colors.white, // White color for the arrow
            ),
            onPressed: () {
              Navigator.pop(context); // Action to go back
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Section with Gradient and Book Image
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none, // Allows overflow for the image
                  children: [
                    // Gradient Background

                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(88, 11, 56, 1.0), // Darker color
                            Colors.white, // Lighter towards bottom
                          ],
                        ),
                      ),
                    ),
                    // Book Cover Image (Overflow)
                    Positioned(
                      bottom: -50, // Adjust to overlap the white section
                      child: Image.network(
                        book.coverImageUrl,
                        height: 200, // Book cover height
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60), // Spacer for the image overlap

              // Book Information Section
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                book.author,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                book.category,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              // Ratings and Duration Row
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    Text(' 4.7'),
                    SizedBox(width: 10),
                    Icon(Icons.access_time, size: 18),
                    Text(' 2 hours'),
                    SizedBox(width: 10),
                    Icon(Icons.language, size: 18),
                    Text(' English'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Year Section
                  const Column(
                    children: const [
                      Text(
                        '2019',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'published in',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // Vertical Divider
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 40, // Spacing between items
                    ),
                  ),

                  // Pages Section
                  Column(
                    children: [
                      Text(
                        book.numberOfPages,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Pages',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // Vertical Divider
                  const SizedBox(
                    height: 30,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1,
                      width: 40, // Spacing between items
                    ),
                  ),

                  // Reviews Section
                  const Column(
                    children: [
                      Text(
                        '210',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Book Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  book.discribtion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Buttons for Read and Listen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      final String pdfUrl =
                          book.previewLink; // Ensure this is a valid PDF link
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerScreen(pdfUrl: pdfUrl),
                        ),
                      );
                    },
                    icon: const Icon(Icons.book),
                    label: const Text('Read'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!savedBooks.contains(book)) {
                        savedBooks.add(book);

                        // Show a confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green[500],
                            content: Text('${book.title} has been saved!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
                            content: Text('${book.title} is already saved!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.bookmark),
                    label: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
