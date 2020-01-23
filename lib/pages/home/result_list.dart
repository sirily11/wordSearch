import 'package:flutter/material.dart';
import 'package:word_finder/models/chinese_word.dart';
import 'package:word_finder/pages/home/result_line.dart';

class WordList extends StatelessWidget {
  final List<ChineseWord> words;
  WordList({this.words});

  String _getExplanation(ChineseWord word) {
    List<String> str = word.explanation.split("\n");
    String retStr = "";
    for (var s in str) {
      retStr += "$s";
    }
    return retStr;
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.separated(
        itemCount: words.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          ChineseWord word = words[index];
          return ResultLine(
            word: word,
          );
        },
      ),
    );
  }
}
