import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vpec/models/admin_model.dart';
import 'package:vpec/ui/widgets/admin_card.dart';
import 'package:vpec/utils/theme_helper.dart';

class AdminScreen extends StatelessWidget {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('administration_list').snapshots();

  @override
  Widget build(BuildContext context) {
    ThemeHelper().colorStatusBar(context: context, isTransparent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Администрация'),
        brightness:
            ThemeHelper().isDarkMode() ? Brightness.dark : Brightness.light,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return _buildLoadingIndicator();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: snapshot.data.docs.map((document) {
                return AdminCard(
                  admin: AdminModel.fromMap(document.data(), document.id),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Center _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}