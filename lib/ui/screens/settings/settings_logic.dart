import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../utils/hive_helper.dart';
import '../../../utils/rounded_modal_sheet.dart';
import '../../../utils/snackbars.dart';
import '../../../utils/theme_helper.dart';
import 'settings_ui.dart';

enum UserMode {
  admin, // have access to view all announcements and edit mode
  student, // can see only public announcements
  employee, // can see public and employee announcements
  teacher, // can see public and teachers announcements
  enrollee, // can't see anything except info about college
}

class SettingsLogic extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isEditMode = HiveHelper.getValue('isEditMode') ?? false;
  late StreamSubscription<User?> authListener;

  static bool get checkIsInEditMode {
    return SettingsLogic.getAccountMode() == UserMode.admin &&
        (HiveHelper.getValue('isEditMode') ?? false);
  }

  void startListenAuth() {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.email == null) {
        isLoggedIn = false;
        notifyListeners();
      } else {
        isLoggedIn = true;
        notifyListeners();
      }
    });
  }

  Future<void> cancelListener() async {
    await authListener.cancel();
  }

  // show roundedModalSheet() for account login
  void accountLogin(BuildContext context) {
    roundedModalSheet(
      context: context,
      title: 'Войти в аккаунт',
      child: AccountLoginUI(),
    );
  }

  // login to firebase account with email and password
  void makeLogin(BuildContext context,
      {required String email, required password}) async {
    try {
      // trying to login
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pop(context);
      showSnackbar(context, text: 'Вход в аккаунт выполнен успешно');
    } on FirebaseAuthException {
      Navigator.pop(context);
      showSnackbar(context, text: 'Данные введены неверно');
    }
  }

  // show roundedModalSheet() for editing user's name
  // (name used for announcements post)
  void changeName(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    roundedModalSheet(
      title: 'Изменить имя',
      context: context,
      child: EditNameUI(nameController: nameController),
    );
  }

  @deprecated
  String? getAccountEmail() {
    if (FirebaseAuth.instance.currentUser!.email != null) {
      return FirebaseAuth.instance.currentUser!.email;
    } else {
      return '';
    }
  }

  static UserMode getAccountMode() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      switch (auth.currentUser!.email) {
        case 'admin@energocollege.ru':
          return UserMode.admin;
        case 'employee@energocollege.ru':
          return UserMode.employee;
        case 'teacher@energocollege.ru':
          return UserMode.teacher;
        case 'student@energocollege.ru':
          return UserMode.student;
        default:
          return UserMode.enrollee;
      }
    } else {
      return UserMode.enrollee;
    }
  }

  static String getAccountModeText() {
    switch (getAccountMode()) {
      case UserMode.admin:
        return 'Администратор';
      case UserMode.student:
        return 'Студент';
      case UserMode.employee:
        return 'Работник';
      case UserMode.teacher:
        return 'Преподаватель';
      case UserMode.enrollee:
        return 'Абитуриент';
    }
  }

  static bool doAccountHaveAccess(UserMode requiredMode) {
    switch (getAccountMode()) {
      case UserMode.admin:
        return true; // admin have access to anything
      case UserMode.student:
        if (requiredMode == UserMode.enrollee ||
            requiredMode == UserMode.student) {
          return true; // students can see stuffs for enrolle and students
        } else {
          return false;
        }
      case UserMode.employee:
        if (requiredMode == UserMode.employee ||
            requiredMode == UserMode.student ||
            requiredMode == UserMode.enrollee) {
          return true;
          // employee can see stuffs only for employee, not for teachers or admin
        } else {
          return false;
        }
      case UserMode.teacher:
        if (requiredMode == UserMode.teacher ||
            requiredMode == UserMode.student ||
            requiredMode == UserMode.enrollee) {
          return true;
          // teachers can see stuffs only for teachers, not for employee or admin
        } else {
          return false;
        }
      case UserMode.enrollee:
        if (requiredMode == UserMode.enrollee) {
          return true;
          // well... enrolle can see something only for enrolle
        } else {
          return false;
        }
    }
  }

  static bool isAccountModeLowLevel() {
    if (getAccountMode() == UserMode.student ||
        getAccountMode() == UserMode.enrollee) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> chooseTheme(
      {required BuildContext context, required bool isAppThemeSetting}) async {
    String hiveKey = isAppThemeSetting ? 'theme' : 'pdfTheme';

    await roundedModalSheet(
      context: context,
      title: 'Выберите тему',
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, value, Widget? child) {
          return ThemeChooserUI(
            hiveKey: hiveKey,
            lightThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Светлая тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            darkThemeSelected: () {
              HiveHelper.saveValue(key: hiveKey, value: 'Тёмная тема');
              if (isAppThemeSetting) value.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            defaultThemeSelected: () {
              HiveHelper.removeValue(hiveKey);
              if (isAppThemeSetting) value.changeTheme(ThemeMode.system);
              Navigator.pop(context);
            },
            alwaysLightThemeDocumentChanged: (value) {
              HiveHelper.saveValue(
                  key: 'alwaysLightThemeDocument', value: value);
            },
          );
        },
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              ThemeHelper.isDarkMode() ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness:
              ThemeHelper.isDarkMode() ? Brightness.light : Brightness.dark),
    );
  }

  void chooseLaunchOnStart(BuildContext context) {
    roundedModalSheet(
        context: context,
        title: 'Открывать при запуске',
        child: LaunchOnStartChooserUI());
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    HiveHelper.saveValue(key: 'isEditMode', value: isEditMode);
    notifyListeners();
  }
}
