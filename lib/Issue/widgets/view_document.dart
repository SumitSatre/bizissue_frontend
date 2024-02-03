/*
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin_ios_android/flutter_webview_plugin_ios_android.dart';

class DocumentViewer extends StatefulWidget {
  final String firebaseDocumentUrl;

  const DocumentViewer({Key? key, required this.firebaseDocumentUrl})
      : super(key: key);

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.firebaseDocumentUrl,
      withZoom: true,
      withLocalStorage: true,
      appBar: AppBar(
        title: const Text("Document Viewer"),
      ),
    );
  }
}
*/