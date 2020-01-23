import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_finder/models/chinese_word.dart';
import 'package:lpinyin/lpinyin.dart';

class WordSearchModel with ChangeNotifier {
  List<ChineseWord> words = [];
  List<ChineseWord> resultList = [];

  WordSearchModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    var text = await rootBundle.loadString("assets/word.json");
    List data = jsonDecode(text);
    this.words = data.map((d) => ChineseWord.fromJson(d)).toList();
  }

  List<ChineseWord> search({String text, String meaning}) {
    String pinyin = PinyinHelper.getPinyin(
        text.substring(text.length - 1, text.length),
        format: PinyinFormat.WITH_TONE_MARK);

    //match pinyin with length 4
    List<ChineseWord> results1 = [];
    //match pinyin with length 3
    List<ChineseWord> results2 = [];
    //match pinyin with length 2
    List<ChineseWord> results3 = [];
    //match pinyin with length 1
    List<ChineseWord> results4 = [];

    if (pinyin.length > 3) {
      results4 = words
          .where((w) =>
              w.pinyin.contains(pinyin) &&
              w.explanation.contains(meaning) &&
              w.word != text)
          .toList();
      pinyin = pinyin.substring(1);
    }

    if (pinyin.length > 2) {
      results3 = words
          .where((w) =>
              w.pinyin.contains(pinyin) &&
              w.explanation.contains(meaning) &&
              w.word != text)
          .toList();
      pinyin = pinyin.substring(1);
    }

    if (pinyin.length > 1) {
      results2 = words
          .where((w) =>
              w.pinyin.contains(pinyin) &&
              w.explanation.contains(meaning) &&
              w.word != text)
          .toList();
      pinyin = pinyin.substring(1);
    }

    results1 = words
        .where((w) =>
            w.pinyin.substring(0, w.pinyin.length) == pinyin &&
            w.explanation.contains(meaning) &&
            w.word != text)
        .toList();

    this.resultList =
        [...results4, ...results3, ...results2, ...results1].toSet().toList();
    notifyListeners();
    return this.resultList;
  }
}
