import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utils/theme_helper.dart';

class CabinetsMapLogic extends ChangeNotifier {
  int selectedFloor = 1;
  int scaleFactor = 1;
  String nowImageUrl = '';

  void setNewFloor(int newFloor) {
    _setFloor(newFloor);
    updateImage();
  }

  void _setFloor(int newFloor) {
    selectedFloor = newFloor;
    notifyListeners();
  }

  void setScale(int newScale) {
    scaleFactor = newScale;
    notifyListeners();
  }

  Future<void> updateImage() async {
    nowImageUrl = await getScaledImage();
    notifyListeners();
  }

  Future<String> getScaledImage() async {
    String fieldName = '';
    switch (scaleFactor) {
      case 1:
        fieldName = 'firstScale';
        break;
      case 2:
        fieldName = 'secondScale';
        break;
      default:
        fieldName = 'firstScale';
        break;
    }

    late String collectionPath;
    if (ThemeHelper.isDarkMode) {
      collectionPath = 'cabinets_map_dark';
    } else {
      collectionPath = 'cabinets_map_light';
    }

    DocumentSnapshot cabMap = await FirebaseFirestore.instance
        .collection(collectionPath)
        .doc('map_0$selectedFloor')
        .get();
    return cabMap[fieldName].toString();
  }

  Future<void> initializeMap(BuildContext context) async {
    nowImageUrl = await CabinetsMapLogic().getScaledImage();
    ThemeNotifier themeNotifier = context.read<ThemeNotifier>();
    themeNotifier.addListener(() async {
      await updateImage();
      notifyListeners();
    });

    notifyListeners();
  }

  void scaleListener(double scale) {
    if (scale < 2.0) {
      if (scaleFactor != 1) {
        setScale(1);
        updateImage();
      }
    }
    if (scale > 2.0) {
      if (scaleFactor != 2) {
        setScale(2);
        updateImage();
      }
    }
  }
}
