import 'package:flutter/material.dart';
import 'package:flutter_app_tdd_riverpod/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberTriviaPage(),
    );
  }
}
