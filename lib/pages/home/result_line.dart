import 'dart:math';

import 'package:flutter/material.dart';
import 'package:word_finder/models/chinese_word.dart';

class ResultLine extends StatefulWidget {
  final ChineseWord word;

  ResultLine({this.word});

  @override
  _ResultLineState createState() => _ResultLineState();
}

class _ResultLineState extends State<ResultLine>
    with SingleTickerProviderStateMixin {
  bool shouldExpand = true;
  AnimationController animationController;
  Animation arrowAnimation;

  @override
  initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    arrowAnimation = Tween(begin: 0.0, end: pi).animate(animationController);
  }

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
    return ListTile(
      onTap: () {
        setState(() {
          shouldExpand
              ? animationController.forward()
              : animationController.reverse();
          shouldExpand = !shouldExpand;
        });
      },
      title: Text("${widget.word.word} ${widget.word.pinyin}"),
      subtitle: AnimatedContainer(
        height: shouldExpand ? 0 : 120,
        duration: Duration(milliseconds: 300),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text("${_getExplanation(widget.word)}"),
          ),
        ),
      ),
      trailing: AnimatedBuilder(
        animation: arrowAnimation,
        builder: (context, child) => Transform.rotate(
          angle: arrowAnimation.value,
          child: Icon(
            Icons.expand_more,
          ),
        ),
      ),
    );
  }
}
