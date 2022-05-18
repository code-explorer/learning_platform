import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';

class JourneyPage extends StatelessWidget {
  LearningPathParameter? parameter;

  JourneyPage({Key? key}) : super(key: key);

  Future<List<Widget>> getJourneyTasks(BuildContext context) async {
    String url = parameter!.url;
    var json = await getJsonData(url);
    var content = json['content'];
    List<Widget> tasks = [];

    for (var task in content) {
      String type = task['type'];
      Icon icon;
      if (type == 'theory') {
        icon = const Icon(Icons.library_books);
      } else if (type == 'quiz') {
        icon = const Icon(Icons.quiz);
      } else {
        icon = const Icon(Icons.edit);
      }

      tasks.add(NeumorphicButton(
        child: ListTile(
          title: Text(task['name']),
          leading: icon,
        ),
        onPressed: () {
          if (type == 'theory') {
            Navigator.pushNamed(
              context,
              '/journey/theory',
              arguments: TheoryParameter(task['name'], task['link']),
            );
          } else if (type == 'quiz') {
            Navigator.pushNamed(
              context,
              '/journey/quiz',
              arguments: QuizParameter(task['name'], task['link']),
            );
          } else {}
        },
      ));
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LearningPathParameter;
    parameter = args;

    return Scaffold(
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
      ),
      body: FutureBuilder<List<Widget>>(
        builder: ((context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = snapshot.data!;
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              Center(child: CircularProgressIndicator())
            ];
          }

          return ListView.separated(
            shrinkWrap: true,
            itemCount: children.length,
            itemBuilder: ((context, index) {
              return children[index];
            }),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          );
        }),
        future: getJourneyTasks(context),
      ),
    );
  }
}
