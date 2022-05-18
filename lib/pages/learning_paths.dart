import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/getwidget.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';
import 'package:learning_platform/widgets/appbar.dart';

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
        child: GFListTile(
          titleText: link['name'],
          subTitleText: link['description'],
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
      backgroundColor: const Color.fromRGBO(202, 240, 248, 1),
      appBar: getAppBar(context, 'Learning Path'),
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
          future: getLearningPaths(context),
        ),
      ),
    );
  }
}
