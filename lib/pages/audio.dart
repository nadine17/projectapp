import 'package:flutter/material.dart';

class BookAudioPage extends StatelessWidget {
  const BookAudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE0E5),
      // Background color matching the design
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Back arrow and time (optional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.black),
                    Text(
                      '9:41',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Book Cover
                Center(
                  child: Image.asset(
                    'assets/images/bookCover.jpeg', // Replace with your asset path
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                // Book Title and Author
                Text(
                  'IT ENDS WITH US',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'COLLEEN HOOVER',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 20),
                // Book Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'It Ends With Us by Colleen Hoover is a powerful and emotional story about Lily Bloom, a young woman who falls in love with Ryle Kincaid, a charming but troubled neurosurgeon. As their relationship deepens, Ryle\'s dark side emerges, forcing Lily to confront painful memories of her abusive childhood. When her first love, Atlas, reappears, she must make difficult choices about love, resilience, and breaking the cycle of abuse.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
                SizedBox(height: 20),
                // Audio Progress Bar
                Slider(
                  value: 10, // Example current time
                  min: 0,
                  max: 24.56, // Total duration in seconds (example)
                  onChanged: (value) {},
                ),
                // Audio Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.fast_rewind, size: 32),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.replay_10, size: 32),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.play_circle_fill,
                          size: 48, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.forward_10, size: 32),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.fast_forward, size: 32),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Playback Speed
                Text(
                  '1.0x',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
