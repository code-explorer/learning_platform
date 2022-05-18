import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

PreferredSizeWidget getAppBar(BuildContext context, String title) {
  return NeumorphicAppBar(
    title: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const Spacer(),
        SvgPicture.asset('assets/icon.svg'),
      ],
    ),
    color: const Color.fromRGBO(23, 23, 23, 1),
    leading: NeumorphicButton(
      child: const Icon(
        Icons.arrow_back,
        color: Color.fromARGB(186, 111, 120, 124),
      ),
      style: const NeumorphicStyle(
        shape: NeumorphicShape.concave,
        color: Color.fromRGBO(21, 21, 21, 1),
        boxShape: NeumorphicBoxShape.circle(),
        shadowLightColor: Color.fromARGB(104, 247, 248, 248),
        shadowLightColorEmboss: Color.fromARGB(127, 247, 248, 248),
        shadowDarkColor: Color.fromRGBO(21, 21, 21, 1),
        shadowDarkColorEmboss: Color.fromRGBO(21, 21, 21, 1),
        depth: 5,
        intensity: 0.8,
        surfaceIntensity: 0.25,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
