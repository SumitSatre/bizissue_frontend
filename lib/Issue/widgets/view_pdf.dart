import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MyPdfViewer extends StatefulWidget {
  final String pdfUrl;

  const MyPdfViewer({required this.pdfUrl});

  @override
  _MyPdfViewerState createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  PDFViewController? pdfViewController;
  int currentPage = 0;
  int totalPages = 0;
  String fileP = '';
  bool isReady = false;
  String errorMessage = '';
  @override
  void initState() {
    print(widget.pdfUrl);
    _loadPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Stack(
        children: [
          fileP == ''
              ? CircularProgressIndicator()
              : PDFView(
            filePath: fileP,
            fitEachPage: true,
            fitPolicy: FitPolicy.BOTH,
            onRender: (_pages) {
              setState(() {
                if (_pages != null) {
                  totalPages = _pages;
                }
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$error';
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                pdfViewController = vc;
              });
            },
          ),
          if (errorMessage.isEmpty)
            if (!isReady)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Container()
          else
            Center(
              child: Text(errorMessage),
            ),
        ],
      ),
    );
  }

  Future<void> _loadPdf() async {
    try {
      setState(() {
        isReady = false;
      });

      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final data = response.bodyBytes;
        final directory = await getDownloadsDirectory();
        print('This is : ${directory?.path}/my_file.pdf');
        final file = File('/storage/emulated/0/Download/my_file.pdf');
        await file.writeAsBytes(data);
        print(file.path);

        setState(() {
          isReady = true;
          fileP = file.path;
        });
        print(fileP);
      } else {
        throw 'Failed to load PDF: ${response.statusCode}';
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      print(e);
    }
    }
}