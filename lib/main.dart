import 'package:calc_clone/constants.dart';
import 'package:calc_clone/widgets/keypad.dart';
import 'package:flutter/material.dart';

import 'logic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String txtResult = "0";
  Logic _logic = Logic();

  @override
  Widget build(BuildContext context) {
    Function onTap = (String text) {
      _logic.input(text);
      setState(() {
        txtResult = _logic.text;
      });
    };

    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        margin: EdgeInsets.only(bottom: 20, right: 5, left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      txtResult.toString(),
                      style: TextStyle(
                        color: colorText,
                        fontSize: 60,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      key: Key("txtResult"),
                    ),
                  ),
                ],
              ),
            ),
            KeyPad(onTap),
          ],
        ),
      ),
    );
  }
}
