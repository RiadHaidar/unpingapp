import 'package:flutter/material.dart';
import 'package:unpingapp/core/di/dependency_injection.dart';
import 'package:unpingapp/core/helpers/window_helper.dart';
import 'unpingapp.dart';

void main() async {

   WidgetsFlutterBinding.ensureInitialized();
    await WindowHelper.initializeWindow();

  setupDependencies();


  runApp(const UnpingApp());
}