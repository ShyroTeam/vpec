import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/firebase_auth.dart';
import '/utils/utils.dart';
import '../../utils/hive_helper.dart';
import '../../widgets/snackbars.dart';
import 'announcements_ui.dart';

class AnnouncementsLogic {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void createNewAnnouncement(BuildContext context) {
    int docID = DateTime.now().millisecondsSinceEpoch;
    bool isUserAddPhoto = false;
    String userPhotoUrl = '';

    Future<void> pickPhoto() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        isUserAddPhoto = true;
        try {
          var result = await FirebaseStorage.instance
              .ref('announcements/$docID')
              .putFile(file);

          userPhotoUrl = await result.ref.getDownloadURL();
        } on FirebaseException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      }
    }

    String collectionPath(AccessLevel accessLevel) {
      switch (accessLevel) {
        case AccessLevel.employee:
          return 'announcements_employee';
        case AccessLevel.teacher:
          return 'announcements_teachers';
        case AccessLevel.entrant:
          return 'announcements_all';
        default:
          return 'announcements_all';
      }
    }

    void sendNewAlert(
        {required BuildContext context, required AccessLevel accessLevel}) async {
      CollectionReference users =
          FirebaseFirestore.instance.collection(collectionPath(accessLevel));

      DateFormat formatter = DateFormat('HH:mm, d MMM yyyy');
      String pubDate = formatter.format(DateTime.now());

      users
          .doc(docID.toString())
          .set({
            'author': HiveHelper.getValue('username'),
            'content_body': contentController.text,
            'visibility': accessLevel == AccessLevel.employee
                ? 'employee'
                : accessLevel == AccessLevel.teacher
                    ? 'teachers'
                    : 'all',
            'date': pubDate,
            'content_title': titleController.text,
            'photo': isUserAddPhoto ? userPhotoUrl : null,
            'id': docID.toString(),
          })
          .then((value) => showSnackBar(context, text: '???????????????????? ????????????????????'))
          .catchError((error) => showSnackBar(context, text: '????????????: $error'));
      Navigator.pop(context);
    }

    void confirmAnnouncementSend() {
      showRoundedModalSheet(
          context: context,
          title: '???????? ???????????????????',
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('????????????'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => sendNewAlert(
                      context: context, accessLevel: AccessLevel.student),
                  child: const Text('?????????????????? ????????'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => sendNewAlert(
                      context: context, accessLevel: AccessLevel.employee),
                  child: const Text('?????????????????? ??????????????????????'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => sendNewAlert(
                      context: context, accessLevel: AccessLevel.teacher),
                  child: const Text('?????????????????? ????????????????????????????'),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ));
    }

    showRoundedModalSheet(
      context: context,
      title: '?????????? ????????????????????',
      child: NewAnnouncementUI(
        titleController: titleController,
        contentController: contentController,
        isUserAddPhoto: isUserAddPhoto,
        userPhotoUrl: userPhotoUrl,
        pickPhoto: () => pickPhoto(),
        confirmAnnouncementSend: () => confirmAnnouncementSend(),
      ),
    );
  }
}
