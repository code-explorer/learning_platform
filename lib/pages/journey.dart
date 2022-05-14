import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';

class JourneyPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        onPressed: () {},
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
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Loading...'),
              )
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
      drawer: Drawer(
        child: Column(
          children: [
            NeumorphicButton(
              child: Row(children: const [
                Icon(Icons.settings),
                Text('Settings'),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
