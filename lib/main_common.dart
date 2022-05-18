import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'injection/injection_container.dart';
import 'presentation/app.dart';

enum Environment { dev, prod }

void mainCommon(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(env);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const App());
}
