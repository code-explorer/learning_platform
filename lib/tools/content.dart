import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:learning_platform/tools/retriever.dart';

class TheoryContent {
  final int id;
  final String markdownLink;

  String? markdownContent;

  TheoryContent(this.id, this.markdownLink);

  Future<Widget> getMarkdownContent() async {
    markdownContent = await fetchData(markdownLink);
    return Markdown(data: markdownContent!);
  }
}

class QuizContent {
  final int id;
  final String quizLink;
  final int quizID;

  List<QuizQuestion>? questions;

  QuizContent(this.id, this.quizLink, this.quizID);
}

class QuizQuestion {
  final int id;
  final String type;
  final String question;
  final List<String> options;
  final List<int> answer;

  QuizQuestion(this.id, this.type, this.question, this.options, this.answer);
}

class ExerciseContent {
  final int id;
  final String questionMarkdownLink;
  final String testCaseLink;
  final int testCaseID;

  List<TestCase>? testCases;

  ExerciseContent(
      this.id, this.questionMarkdownLink, this.testCaseLink, this.testCaseID);
}

class TestCase {
  final int id;
  final String inputType;
  final dynamic input;
  final String outputType;
  final dynamic output;

  TestCase(this.id, this.inputType, this.input, this.outputType, this.output);
}
