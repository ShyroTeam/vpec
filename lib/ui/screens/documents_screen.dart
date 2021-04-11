import 'package:flutter/material.dart';
import 'package:vpec/utils/theme_helper.dart';

import 'menu/menu_ui.dart';

class DocumentsScreen extends StatefulWidget {
  @override
  _DocumentsScreenState createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, haveAppbar: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Документы'),
      ),
      body: Column(
        children: [
          ViewDocuments(),
        ],
      ),
    );
  }
}