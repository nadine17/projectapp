// lib/models/book.dart
class Book {
  final String title;
  final String coverImageUrl;
  final String author;
  final String category;
  final String previewLink;
  final int numberOfPages;
  final String audiobookLink;
  final String discribtion;

  Book({
    required this.title,
    required this.coverImageUrl,
    required this.author,
    required this.category,
    required this.previewLink,
    required this.numberOfPages,
    required this.audiobookLink,
    required this.discribtion,
  });
}
