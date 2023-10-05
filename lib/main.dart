import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'my_location_app.dart';

void main() async {
  await _initApp();
  runApp(const MyLocationApp());
}

/// Initialize the app.
Future<void> _initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // loadLocationHistoryListAction();
}
