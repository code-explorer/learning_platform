import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/pages/journey.dart';
import 'package:learning_platform/pages/learning_paths.dart';
import 'package:learning_platform/pages/onboarding.dart';
import 'package:learning_platform/pages/quiz.dart';
import 'package:learning_platform/pages/theory.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Learning Platform',
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingPage(),
        '/paths': (context) => const LearningPathsPage(),
        '/journey': (context) => JourneyPage(),
        '/journey/theory': (context) => TheoryPage(),
        '/paths/journey/theory': (context) => TheoryPage(),
        '/journey/quiz': (context) => const QuizPage(),
        '/paths/journey/quiz': (context) => const QuizPage()
      },
      themeMode: ThemeMode.light,
    );
  }
}
