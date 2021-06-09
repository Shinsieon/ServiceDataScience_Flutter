import 'package:flutter/material.dart';
const String _title = '결과페이지';
class resultpage extends StatelessWidget{
  List sent_array;
  resultpage({Key key, @required this.sent_array}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: Text("hi")
        ),
      ),
    );
  }
}
/*class result_StatefulWidget extends StatefulWidget {
  result_StatefulWidget({Key key}) : super(key: key);
  @override
  result_state createState() => result_state();
}

class result_state extends State<result_StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("결과페이지입니다."));
  }
}*/