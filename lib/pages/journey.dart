import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';
import 'package:learning_platform/widgets/appbar.dart';

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
        child: GFListTile(
          titleText: task['name'],
          icon: icon,
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
        backgroundColor: const Color.fromRGBO(202, 240, 248, 1),
        appBar: getAppBar(context, args.name),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Widget>>(
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
        ));
  }
}
