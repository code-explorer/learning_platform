import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';

class LearningPathsPage extends StatelessWidget {

  const LearningPathsPage({Key? key}) : super(key: key);

  Future<List<Widget>> getLearningPaths(BuildContext context) async {
    String url =
        "https://gist.githubusercontent.com/code-explorer/d9f8631ac60e427edd58e098251fa932/raw/test_paths.json";
    var json = await getJsonData(url);
    var links = json['links'];
    List<Widget> paths = [];

    for (var link in links) {
      paths.add(NeumorphicButton(
        child: ListTile(
          title: Text(link['name']),
          subtitle: Text(link['description']),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/journey',
            arguments: LearningPathParameter(link['name'], link['link']),
          );
        },
      ));
    }

    return paths;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text('Learning Paths'),
        centerTitle: true,
        actions: [
          NeumorphicButton(
            child: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        leading: null,
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
        future: getLearningPaths(context),
      ),
    );
  }
}
