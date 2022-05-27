import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class MyDesktopBody extends StatefulWidget {
  const MyDesktopBody({Key? key}) : super(key: key);

  @override
  _MyDesktopBodyState createState() => _MyDesktopBodyState();
}

class _MyDesktopBodyState extends State<MyDesktopBody> {
  //按鈕的內部元素(按鈕文字、按鈕顏色、文字顏色)
  Widget btn(String btntxt, Color btncolor, Color txtcolor) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: RaisedButton(
          onPressed: () {
            calculation(btntxt);
          },
          child: Text(
            '$btntxt',
            style: TextStyle(
              fontSize: 35,
              color: (btntxt == selectedOperation && currentNumber == "")
                  ? btncolor : txtcolor,
            ),
          ),
          shape: CircleBorder(),
          color: (btntxt == selectedOperation && currentNumber == "")
              ? Colors.white : btncolor,
          padding: EdgeInsets.all(20.0),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator_Mobile"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      text,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: text.length > 5 ? 60 : 80,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                )
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //按鈕的widget會透過參數被呼叫於此
              btn('AC', Colors.grey, Colors.black),
              btn('+/-', Colors.grey, Colors.black),
              btn('%', Colors.grey, Colors.black),
              btn('/', Colors.amber, Colors.white),
            ],
          ),
          //SizedBox用於框架之間的padding
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btn('7', Colors.blueGrey, Colors.white),
              btn('8', Colors.blueGrey, Colors.white),
              btn('9', Colors.blueGrey, Colors.white),
              btn('x', Colors.amber, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btn('4', Colors.blueGrey, Colors.white),
              btn('5', Colors.blueGrey, Colors.white),
              btn('6', Colors.blueGrey, Colors.white),
              btn('-', Colors.amber, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btn('1', Colors.blueGrey, Colors.white),
              btn('2', Colors.blueGrey, Colors.white),
              btn('3', Colors.blueGrey, Colors.white),
              btn('+', Colors.amber, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 23.0),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
                      onPressed: () {
                        calculation('0');
                      },
                      shape: StadiumBorder(),
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
              btn('.', Colors.blueGrey, Colors.white),
              btn('=', Colors.amber, Colors.white),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  dynamic text = "0";


  String previousNumber = "";
  String currentNumber = "";
  String selectedOperation = "";

  void calculation(String btntxt) {
    setState(() {
      switch (btntxt) {
        case "/":
        case "x":
        case "-":
        case "+":
          if (previousNumber != '') {
            calculateResult();
          } else {
            previousNumber = currentNumber;
          }
          currentNumber = "";
          selectedOperation = btntxt;
          break;
        case "+/-":
          currentNumber = currentNumber.toString().startsWith('-')
              ? currentNumber = currentNumber.toString().substring(1)
              : currentNumber = '-' + currentNumber.toString();
          text = currentNumber;
          break;
        case "%":
          currentNumber =
              (convertStringToDouble(currentNumber) / 100).toString();
          text = currentNumber;
          break;
        case "=":
          calculateResult();
          previousNumber = '';
          selectedOperation = '';
          break;
        case "AC":
          text = '0';
          previousNumber = '';
          currentNumber = '';
          selectedOperation = '';
          break;
        default:
          currentNumber = currentNumber + btntxt;
          text = currentNumber;
      }
    });
  }

  void calculateResult() {
    double _prevoisNumber = convertStringToDouble(previousNumber);
    double _currentNumber = convertStringToDouble(currentNumber);
    switch (selectedOperation) {
      case '/':
        _prevoisNumber = (_prevoisNumber / _currentNumber);
        break;
      case 'x':
        _prevoisNumber = _prevoisNumber * _currentNumber;
        break;
      case '-':
        _prevoisNumber = _prevoisNumber - _currentNumber;
        break;
      case '+':
        _prevoisNumber = _prevoisNumber + _currentNumber;
        break;
      default:
        break;
    }
    currentNumber = _prevoisNumber.toString();
    text = currentNumber;
    if(text == "Infinity"){
      text = 'error';
      print('error');
    }
  }

  double convertStringToDouble(String number) {
    return double.tryParse(number) ?? 0;
  }
}
