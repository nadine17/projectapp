import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        backgroundColor: const Color.fromRGBO(88, 11, 56, 1.0),
      ),
      body: SfPdfViewer.network(
        pdfUrl, // The PDF URL passed to the screen
      ),
    );
  }
}
