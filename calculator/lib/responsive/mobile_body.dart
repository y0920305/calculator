import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyMobileBody extends StatefulWidget {
  const MyMobileBody({Key? key}) : super(key: key);

  @override
  _MyMobileBodyState createState() => _MyMobileBodyState();
}

class _MyMobileBodyState extends State<MyMobileBody> {
  /* String result = '';
  String equation = '';
  String expression = '';

  // Button的功能
  calculation(String buttonText) {
    setState(() {
      //AC Button
        if (buttonText == 'AC') {
          result = '0';
          equation = '0';
        }
        //Button '+/-' 正負號轉換，以是否存在負號開頭作為判斷式，True則由負轉正、False則由正轉負
        else if (buttonText == "+/-") {
          equation = equation.toString().startsWith('-')
              ? equation.toString().substring(1)
              : '-' + equation.toString();
          if (buttonText == "") {
            equation = "0";
          }
        } else if (buttonText == '=') {
          expression = equation;
          expression = expression.replaceAll('x', '*');
          expression = expression.replaceAll('÷', '/');
          try {
            //使用math_expression函式庫
            //創建表達式
            Parser p = Parser();
            Expression exp = p.parse(expression);
            //綑綁變數並將表達式計算為實數
            ContextModel cm = ContextModel();
            equation = '${exp.evaluate(EvaluationType.REAL, cm)}';



          } catch (e) {
            equation = 'error';
          }
        } else {
          if (equation == '0' ||
              equation == "÷" ||
              equation == "x" ||
              equation == "-" ||
              equation == "+" ||
              equation == "%") {
            equation = buttonText;
          }
            else if (equation == "error") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
        print(equation);
    });
  }*/

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
              color: txtcolor,
            ),
          ),
          shape: CircleBorder(),
          color: btncolor,
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
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 65,
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
                flex: 2,child:
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 23.0,right: 23.0),
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

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    try {
      if (btnText == 'AC') {
        text = '0';
        numOne = 0;
        numTwo = 0;
        result = '';
        finalResult = '0';
        opr = '';
        preOpr = '';
      } else if (opr == '=' && btnText == '=') {
        //按下等於直接重複operand運算式
        if (preOpr == '+') {
          finalResult = add();
        } else if (preOpr == '-') {
          finalResult = sub();
        } else if (preOpr == 'x') {
          finalResult = mul();
        } else if (preOpr == '/') {
          finalResult = div();
        }
      } else if (btnText == '+' ||
          btnText == '-' ||
          btnText == 'x' ||
          btnText == '/' ||
          btnText == '=') {
        //第一個值為0直接跳第二個值就不用輸入2次
        if (numOne == 0) {
          numOne = double.parse(result);
        } else {
          numTwo = double.parse(result);
        }

        if (opr == '+') {
          finalResult = add();
        } else if (opr == '-') {
          finalResult = sub();
        } else if (opr == 'x') {
          finalResult = mul();
        } else if (opr == '/') {
          finalResult = div();
        }
        preOpr = opr;
        opr = btnText;
        result = '';
      } else if (btnText == '%') {
        if (numOne == 0) {
          numOne = double.parse(result);
        } else {
          numTwo = double.parse(result);
        }

        result = (numOne / 100).toString();
        numOne = double.parse(result);
        finalResult = doesContainDecimal(result);
      } else if (btnText == '.') {
        if (!result.toString().contains('.')) {
          result = result.toString() + '.';
        }
        finalResult = result;
      } else if (btnText == '+/-') {
        result.toString().startsWith('-')
            ? result = result.toString().substring(1)
            : result = '-' + result.toString();
        finalResult = result;
      } else {
        result = result + btnText;
        finalResult = result;
      }

      setState(() {
        text = finalResult;
        if (text == 'Infinity') {
          text = 'error';
        }
      });
    } catch (e) {
      print('error');
    }
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toStringAsFixed(2).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toStringAsFixed(8).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
