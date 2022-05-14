import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/pages/journey.dart';
import 'package:learning_platform/pages/learning_paths.dart';
import 'package:learning_platform/pages/login.dart';
import 'package:learning_platform/pages/onboarding.dart';
import 'package:learning_platform/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

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
        '/login': (context) => const LoginPage(),
        '/paths': (context) => LearningPathsPage(),
        '/journey': (context) => JourneyPage(),
        '/paths/journey': (context) => JourneyPage()
      },
      themeMode: ThemeMode.light,
    );
  }
}
