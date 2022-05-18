import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icon.svg',
                  color: Colors.black,
                  width: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Neumorphic(
                    child: Column(
                      children: const [
                        Text(
                          'Enjoyable Learning',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: Color.fromARGB(0, 0, 0, 0),
                        ),
                        Text(
                          'An investment in knowledge pays the best interest.',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    style: const NeumorphicStyle(
                        color: Color.fromRGBO(171, 212, 255, 1)),
                  ),
                ),
                const Spacer(),
                NeumorphicButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/paths');
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: const NeumorphicStyle(
                      color: Color.fromRGBO(23, 23, 23, 1)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
