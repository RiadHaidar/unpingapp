import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowHelper {
  WindowHelper._();

  // Platform detection getters
  static bool get kIsLinux => !kIsWeb && Platform.isLinux;
  static bool get kIsMacOS => !kIsWeb && Platform.isMacOS;
  static bool get kIsWindows => !kIsWeb && Platform.isWindows;

  static bool get isDesktop => kIsLinux || kIsMacOS || kIsWindows;

  /// Initializes and configures the window for desktop platforms
  static Future<void> initializeWindow({
    Size minimumSize = const Size(400, 500),
    bool center = true,
    bool skipTaskbar = false,
    TitleBarStyle titleBarStyle = TitleBarStyle.normal,
  }) async {
    if (!isDesktop) return;

    await windowManager.ensureInitialized();

    final WindowOptions windowOptions = WindowOptions(
      minimumSize: minimumSize,
      center: center,
      skipTaskbar: skipTaskbar,
      titleBarStyle: titleBarStyle,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}