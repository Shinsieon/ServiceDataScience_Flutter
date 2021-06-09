import 'package:flutter/material.dart';
import 'survey.dart';
void main() => runApp(MyApp());
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BMI prediction App',
        home: main_page(),
        theme: ThemeData(
            primarySwatch: createMaterialColor(Color(0xFF174378))));
  }
}

class main_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BMI prediction App'),
        ),
        body: Center(
            child: Column(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 41,
                                  color: createMaterialColor(Color(0xFF66BB6A)),
                                  letterSpacing: 3.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "iet",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 41,
                                  color: Colors.black,
                                  letterSpacing: 3.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ]
                      )
                  ),
                  Text(
                    "푸디어트",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.grey,
                        letterSpacing: 3.0
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "당신의 식습관 설문 조사를 분석하여 미래 BMI 지수를 예측하는 서비스를 이용해보세요",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        letterSpacing: 3.0
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Container(
                      margin: const EdgeInsets.all(32),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black) ),
                              onPressed: () {}, child: Text('Google Login')),
                          ElevatedButton(onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => first_surveyApp()),
                            );
                          }, child: Text('Service start')),
                        ],
                      )
                  )
                ]
            )
        )
    );
  }
}

