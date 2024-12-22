import 'package:flutter/material.dart';
import 'package:projectapp/pages/home.dart';

class FeedbackPage extends StatelessWidget {
  final Set<String> selectedGenres;

  FeedbackPage({required this.selectedGenres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Selected Genres'),
        backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thank you for selecting your favorite genres!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have chosen the following genres:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: selectedGenres.isEmpty
                  ? Center(
                      child: Text(
                        'No genres selected. Please go back and choose at least one genre.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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
                              Icons.category,
                              color: Color.fromRGBO(88, 11, 56, 1.0),
                            ),
                            title: Text(
                              genre,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        selectedGenres: selectedGenres), // Pass selected genres
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(88, 11, 56, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Done',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
