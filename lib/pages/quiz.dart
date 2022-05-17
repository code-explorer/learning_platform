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
  List<List<bool>> checkedValues =
      List<List<bool>>.filled(20, List<bool>.filled(5, false));
  List<bool> showAnswer = List<bool>.filled(20, false);

  Widget getQuizQuestions() {
    var jsonQuestions = widget.jsonData['questions'];

    return PageView.builder(
      itemCount: jsonQuestions.length,
      itemBuilder: (context, cardIndex) {
        var question = jsonQuestions[cardIndex];
        if (question['type'] == "single-choice") {
          return Neumorphic(
            child: ListView.builder(
              itemCount: question['options'].length + 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(title: Text(question['question']));
                } else if (index == question['options'].length + 1) {
                  return NeumorphicButton(
                    child: const Text('Check Answer'),
                    onPressed: () {
                      setState(() {
                        showAnswer[cardIndex] = true;
                      });
                    },
                    style: const NeumorphicStyle(color: Colors.blue),
                    margin: const EdgeInsets.all(10),
                  );
                } else if (index == question['options'].length + 2) {
                  if (showAnswer[cardIndex]) {
                    return ListTile(
                      title: Text('Answer: ' + question['answer'].toString()),
                      subtitle: Text(question['solution']),
                    );
                  }
                  return Container();
                }
                return RadioListTile<int>(
                  value: index + 1,
                  groupValue: groupValues[cardIndex],
                  onChanged: (value) {
                    setState(() {
                      groupValues[cardIndex] = value ?? 0;
                    });
                  },
                  title: Text(question['options'][index - 1]),
                );
              },
            ),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              lightSource: LightSource.topLeft,
              color: Colors.grey.shade50,
            ),
            margin: const EdgeInsets.all(20),
          );
        } else {
          return Neumorphic(
            child: ListView.builder(
              itemCount: question['options'].length + 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(title: Text(question['question']));
                } else if (index == question['options'].length + 1) {
                  return NeumorphicButton(
                    child: const Text('Check Answer'),
                    onPressed: () {
                      setState(() {
                        showAnswer[cardIndex] = true;
                      });
                    },
                    style: const NeumorphicStyle(color: Colors.blue),
                    margin: const EdgeInsets.all(10),
                  );
                } else if (index == question['options'].length + 2) {
                  if (showAnswer[cardIndex]) {
                    return ListTile(
                      title: Text('Answer: ' + question['answer'].toString()),
                      subtitle: Text(question['solution']),
                    );
                  }
                  return Container();
                }
                return CheckboxListTile(
                  value: checkedValues[cardIndex][index - 1],
                  onChanged: (newValue) {
                    setState(() {
                      checkedValues[cardIndex][index - 1] = newValue ?? false;
                    });
                  },
                  title: Text(question['options'][index - 1]),
                );
              },
            ),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 8,
              lightSource: LightSource.topLeft,
              color: Colors.grey.shade50,
            ),
            margin: const EdgeInsets.all(20),
          );
        }
      },
      controller: PageController(viewportFraction: 0.95),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getQuizQuestions();
  }
}
