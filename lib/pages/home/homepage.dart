import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_finder/models/word_search_model.dart';
import 'package:word_finder/pages/home/result_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController meaningController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WordSearchModel wordSearchModel = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Word Search"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "押韵词",
                            filled: true,
                            helperText: "在这输入你要押韵的词"),
                        controller: controller,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "意思",
                          filled: true,
                          helperText: "在这输入押韵的结果的意思"),
                      controller: meaningController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      wordSearchModel.search(
                          text: controller.text,
                          meaning: meaningController.text);
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: WordList(
                words: wordSearchModel.resultList,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Text("Number of results: ${wordSearchModel.resultList.length}"),
        ),
      ),
    );
  }
}
