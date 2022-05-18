import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:learning_platform/tools/parameters.dart';
import 'package:learning_platform/tools/retriever.dart';
import 'package:learning_platform/widgets/appbar.dart';

class TheoryPage extends StatelessWidget {
  TheoryParameter? parameter;

  Future<String> getMarkdownFile() async {
    String url = parameter!.url;
    String json = await fetchData(url);
    return json;
  }

  TheoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TheoryParameter;
    parameter = args;
    return Scaffold(
      appBar: getAppBar(context, args.name),
      body: FutureBuilder<String>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
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
        future: getMarkdownFile(),
      ),
    );
  }
}
