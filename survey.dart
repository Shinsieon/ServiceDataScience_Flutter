import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sklite/ensemble/forest.dart';
import 'package:sklite/SVM/SVM.dart';
import 'result.dart';
import 'dart:developer';
import 'package:sklite/utils/io.dart';
import 'dart:async';
import 'package:async/async.dart';

final List<String> basics = <String>['키','몸무게','나이'];
final List<String> danwi = <String>['cm', 'kg', '한국나이'];
final List<String> foods = <String>['피자','햄버거','치킨','라면','아이스크림','초콜릿','쿠키','케이크','소주','커피','쌀밥','떡','돼지고기','소고기'];
final List<String> pattern = <String>['일주일에 얼마나 근력 운동을 하시나요','일주일에 얼마나 걷기 운동을 하시나요','일주일에 얼마나 앉아서 보내세요?'];
var _choice = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
var pattern_choice = [0,0,0];
List<TextEditingController> basic_controller = [
  for (int i = 0; i < basics.length; i++)
    TextEditingController()
];
const String _title = '설문조사';
class first_surveyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: first_StatefulWidget(),
        ),
      ),
    );
  }
}
class first_StatefulWidget extends StatefulWidget {
  first_StatefulWidget({Key key}) : super(key: key);
  @override
  first_survey createState() => first_survey();
  //second_survey createState() => second_survey();
}

class first_survey extends State<first_StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Expanded(
            child: basic_questions
        ),
        ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => second_surveyApp()),
                );
              }, child: Text('Next')),
      ]
    );
  }
  /**/
  Widget basic_questions = ListView.separated(
    itemCount : basics.length,
    separatorBuilder: (BuildContext context, int index) => const Divider(),
    itemBuilder: (BuildContext context, int index){
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        // 로우에 위젯들(Expanded, Icon, Text)을 자식들로 추가
        children: <Widget>[
          // 첫번째 자식
          Expanded(
            // 첫번째 자식의 자식으로 컬럼 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽정렬로 배치함
              // 컬럼의 자식들로 컨테이너와 텍스트를 추가
              children: <Widget>[
                // 컬럼의 첫번째 자식 컨테이너
                Container(
                  padding: const EdgeInsets.only(bottom: 8), // 컨테이너 내부 하단에 8픽셀만큼 패딩 삽입
                  child: Text(  // 컨테이너의 자식으로 텍스트 삽입
                    "${basics[index]}를 입력해주세요",
                    style: TextStyle(
                        fontWeight: FontWeight.bold // 텍스트 강조 설정
                    ),
                  ),
                ),
                // 컬럼의 두번째 자식으로 텍스트 삽입
                TextField(
                  controller: basic_controller[index],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '${danwi[index]}',
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
class second_surveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: second_StatefulWidget(),

        ),
      ),
    );
  }
}
class second_StatefulWidget extends StatefulWidget {
  second_StatefulWidget({Key key}) : super(key: key);
  @override
  second_survey createState() => second_survey();
}
class second_survey extends State<second_StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Expanded(
              child: ListView.separated(
              itemCount : foods.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    // 로우에 위젯들(Expanded, Icon, Text)을 자식들로 추가
                    children: <Widget>[
                      // 첫번째 자식
                      Expanded(
                        // 첫번째 자식의 자식으로 컬럼 추가
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽정렬로 배치함
                          // 컬럼의 자식들로 컨테이너와 텍스트를 추가
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(bottom: 8), // 컨테이너 내부 하단에 8픽셀만큼 패딩 삽입
                              child: Text(  // 컨테이너의 자식으로 텍스트 삽입
                                "일주일에 ${foods[index]} 을/를 몇 번 드시나요?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold // 텍스트 강조 설정
                                ),
                              ),
                            ),
                            Container(
                              child : Row(
                                children: <Widget>[
                                  Radio(
                                    value: 0,
                                    groupValue: _choice[index],
                                    onChanged: (val) {
                                      setState(() {
                                        _choice[index] = val;
                                        //Fluttertoast.showToast(msg: "${index}",toastLength: Toast.LENGTH_SHORT);
                                      });
                                    },
                                  ),
                                  Text(
                                    "거의 먹지 않음",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: _choice[index],
                                    onChanged: (val) {
                                      setState(() {
                                        _choice[index] = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    "주 1회",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _choice[index],
                                    onChanged: (val) {
                                      setState(() {
                                        _choice[index] = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    "주 2~4회",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                  Radio(
                                    value: 3,
                                    groupValue: _choice[index],
                                    onChanged: (val) {
                                      setState(() {
                                        _choice[index] = val;
                                      });
                                    },
                                  ),
                                  Text(
                                    "주 5~7회",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              )
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => third_surveyApp()),
                );
              }, child: Text('Next')),

        ]
    );
  }

}

class third_surveyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: third_StatefulWidget(),

        ),
      ),
    );
  }
}
class third_StatefulWidget extends StatefulWidget {
  third_StatefulWidget({Key key}) : super(key: key);
  @override
  third_survey createState() => third_survey();
}
class third_survey extends State<third_StatefulWidget> {
  RandomForestClassifier rf;
  SVC svc;
  third_survey(){
    loadModel("bmi_classifier.json").then((x) {
      this.rf = RandomForestClassifier.fromMap(json.decode(x));
    });
    loadModel("svciris.json").then((x) {
      this.svc = SVC.fromMap(json.decode(x));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
          Expanded(
            child: ListView.separated(
              itemCount : pattern.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    // 로우에 위젯들(Expanded, Icon, Text)을 자식들로 추가
                    children: <Widget>[
                      // 첫번째 자식
                      Expanded(
                        // 첫번째 자식의 자식으로 컬럼 추가
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 왼쪽정렬로 배치함
                            // 컬럼의 자식들로 컨테이너와 텍스트를 추가
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(bottom: 8), // 컨테이너 내부 하단에 8픽셀만큼 패딩 삽입
                                child: Text(  // 컨테이너의 자식으로 텍스트 삽입
                                  "${pattern[index]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold // 텍스트 강조 설정
                                  ),
                                ),
                              ),
                              Container(
                                  child : Row(
                                    children: <Widget>[
                                      Radio(
                                        value: 0,
                                        groupValue: pattern_choice[index],
                                        onChanged: (val) {
                                          setState(() {
                                            pattern_choice[index] = val;
                                            //Fluttertoast.showToast(msg: "${index}",toastLength: Toast.LENGTH_SHORT);
                                          });
                                        },
                                      ),
                                      Text(
                                        "0~6시간",
                                        style: new TextStyle(fontSize: 10.0),
                                      ),
                                      Radio(
                                        value: 1,
                                        groupValue: pattern_choice[index],
                                        onChanged: (val) {
                                          setState(() {
                                            pattern_choice[index] = val;
                                          });
                                        },
                                      ),
                                      Text(
                                        "6~12시간",
                                        style: new TextStyle(fontSize: 10.0),
                                      ),
                                      Radio(
                                        value: 2,
                                        groupValue: pattern_choice[index],
                                        onChanged: (val) {
                                          setState(() {
                                            pattern_choice[index] = val;
                                          });
                                        },
                                      ),
                                      Text(
                                        "12~15시간",
                                        style: new TextStyle(fontSize: 10.0),
                                      ),
                                      Radio(
                                        value: 3,
                                        groupValue: pattern_choice[index],
                                        onChanged: (val) {
                                          setState(() {
                                            pattern_choice[index] = val;
                                          });
                                        },
                                      ),
                                      Text(
                                        "15시간 이상",
                                        style: new TextStyle(fontSize: 10.0),
                                      ),
                                    ],
                                  )
                              )
                            ]
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => first_surveyApp()),
                );
              }, child: Text('Next')),
          ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
              onPressed: () {
                // Load model
                learnDemo();
              }, child: Text('print')),
        ]
    );
  }
  learnDemo() async{
    List<double> send_array = [];
    send_array.add(double.parse(basic_controller[0].text));
    send_array.add(double.parse(basic_controller[1].text));
    send_array.add(double.parse(basic_controller[2].text));
    send_array.addAll(retint(_choice));
    send_array.addAll(retint(pattern_choice));
    print(send_array);
    //print(this.rf.predict(send_array));
    List<double> X = [5.0, 2.0, 3.5, 1.0];
    print("SVC");
    print(svc.predict(X));
  }
  retint(List lst){
    List<double> new_list = [];
    for(var i=0;i<lst.length;i++){
      new_list.add(lst[i].toDouble());
    }
    return new_list;
  }
}
