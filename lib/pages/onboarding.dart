import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const ListTile(
              title: Text('Add onboarding page'),
            ),
            NeumorphicButton(
              onPressed: () {
                Navigator.pushNamed(context, '/paths');
              },
              child: const Text('Get Started'),
            )
          ],
        ),
      ),
    );
  }
}
