import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vpec/models/announcement_model.dart';
import 'package:vpec/utils/rounded_modal_sheet.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  AnnouncementCard({@required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          onDoubleTap: () => _listPicked(context),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ListTile(
              title: Text(
                announcement.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Linkify(
                      text: announcement.content,
                      style: Theme.of(context).textTheme.bodyText1,
                      options: LinkifyOptions(humanize: true),
                      onOpen: (link) async {
                        if (await canLaunch(link.url)) {
                          await launch(link.url);
                        } else {
                          throw ('Could not launch ${link.url}');
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        announcement.author + ' • ' + announcement.pubDate,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listPicked(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (FirebaseAuth.instance.currentUser.email ==
        "employee@energocollege.ru") {
      titleController.text = announcement.title;
      contentController.text = announcement.content;

      roundedModalSheet(
        context: context,
        title: 'Редактировать объявление',
        contentChild: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                    labelText: 'Введите заголовок',
                    labelStyle: Theme.of(context).textTheme.headline3,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 200, maxHeight: 200),
              child: TextFormField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 10,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline3,
                decoration: InputDecoration(
                    labelText: 'Введите сообщение',
                    alignLabelWithHint: true,
                    labelStyle: Theme.of(context).textTheme.headline3,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor))),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () => _confirmDelete(context),
                  child: Text(
                    'Удалить',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
                TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Отмена',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                ),
                OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text(
                    'Отредактировать',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                  onPressed: () => _updateAlert(context, announcement.docId,
                      titleController.text, contentController.text),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void _updateAlert(BuildContext context, String docId, String titleText,
      String contentText) {
    CollectionReference alerts = FirebaseFirestore.instance
        .collection(announcement.isPublic ? 'alerts' : 'privateAlerts');
    alerts
        .doc(docId)
        .update({'title': titleText, 'content': contentText})
        .then((value) => print("Alert Updated"))
        .catchError((error) => print("Failed to update alert: $error"));
    Navigator.pop(context);
  }

  void _confirmDelete(BuildContext context) {
    Navigator.pop(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) => Container(
              padding: MediaQuery.of(context).viewInsets,
              margin: const EdgeInsets.only(
                  top: 10, left: 15, right: 15, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Удалить объявление?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: Theme.of(context).outlinedButtonTheme.style,
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Отмена',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style,
                      onPressed: () => _deleteAlert(context),
                      child: Text(
                        'Удалить',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void _deleteAlert(BuildContext context) {
    CollectionReference alerts = FirebaseFirestore.instance
        .collection(announcement.isPublic ? 'alerts' : 'privateAlerts');
    alerts
        .doc(announcement.docId)
        .delete()
        .then((value) => print("Alert deleted"))
        .catchError((error) => print("Failed to delete alert: $error"));
    Navigator.pop(context);
  }
}
