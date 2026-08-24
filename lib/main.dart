import 'package:flutter/material.dart';
import 'package:taskaty/core/services/local_storage.dart';
import 'package:taskaty/core/services/service_locator.dart';
import 'package:taskaty/taskaty_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await LocalStorage.initSharedPref();
  runApp(const TaskatyApp());
}
