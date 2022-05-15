import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';

class QuizPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as QuizParameter;
    return Scaffold(
      key: _scaffoldKey,
      appBar: NeumorphicAppBar(
        title: Text(args.name),
        centerTitle: true,
        actions: [
          NeumorphicButton(
            child: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
        leading: NeumorphicButton(
          child: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getJsonData(args.url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return QuizWidget(jsonData: snapshot.data!);
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  final Map<String, dynamic> jsonData;
  const QuizWidget({Key? key, required this.jsonData}) : super(key: key);

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  List<int> groupValues = List<int>.filled(20, 0);

  Widget getQuizQuestions() {
    var jsonQuestions = widget.jsonData['questions'];
    List<Widget> questions = [];
    for (var question in jsonQuestions) {
      List<Widget> options = [
        ListTile(title: Text(question['question'])),
      ];
      int i = 1, j = 0;
      for (var option in question['options']) {
        if (question['type'] == "single-choice") {
          options.add(
            Padding(
              padding: const EdgeInsets.all(8),
              child: NeumorphicRadio<int>(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(option),
                  ),
                ),
                value: i,
                groupValue: groupValues[j],
                onChanged: (int? value) {
                  setState(() {
                    groupValues[j] = value ?? -1;
                  });
                },
                padding: const EdgeInsets.all(2),
              ),
            ),
          );
          i++;
        } else {}
      }
      // j++;

      questions.add(
        Neumorphic(
          child: ListView(
            children: options,
          ),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: Colors.grey.shade50,
          ),
          margin: const EdgeInsets.all(20),
        ),
      );
    }

    return PageView(
      controller: PageController(viewportFraction: 0.9),
      children: questions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return getQuizQuestions();
  }
}
