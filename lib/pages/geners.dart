import 'package:flutter/material.dart';

import 'gener_chip.dart';

class GenresSection extends StatelessWidget {
  const GenresSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Genres',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            GenreChip(label: 'Fantasy'),
            GenreChip(label: 'History'),
            GenreChip(label: 'Horror'),
            GenreChip(label: 'Humor'),
            GenreChip(label: 'Mystery'),
            GenreChip(label: 'Romance'),
          ],
        ),
      ],
    );
  }
}
