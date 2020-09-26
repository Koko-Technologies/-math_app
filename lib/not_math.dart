import 'package:flutter/material.dart';
import 'package:not_math/constants.dart';

class NotMath extends StatefulWidget {
  @override
  _NotMathState createState() => _NotMathState();
}

class _NotMathState extends State<NotMath> {
  String a = '0';
  String b = '0';
  String result = '0';
  String result1;
  bool enabled = false;
  bool solve = false;
  bool isAdd = false;
  bool isSubtract = false;
  bool isMultiply = false;
  bool isDivide = false;

  Widget buildNumberButtons(String num) {
    return Expanded(
      flex: num == '0' ? 2 : 1,
      child: InkWell(
        onTap: () {
          setState(() {
            if (enabled) {
              b += num;
              result = b;
            } else {
              a += num;
              result = a;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: num == '.' ? Color(0xffD6D6D6) : Colors.white,
          ),
          child: Center(
            child: Text(
              num,
              style: kButtonText,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFunctionButtons(String symbol) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            enabled = true;
            if (symbol == '=') {
              isEqual();
            } else if (symbol == '+') {
              add();
              result = '0';
            } else if (symbol == '-') {
              subtract();
              result = '0';
            } else if (symbol == 'x') {
              multiply();
              result = '0';
            } else {
              divide();
              result = '0';
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: enabled ? Color(0xffDB9648) : Color(0xffEB9648)),
          child: Center(
            child: Text(
              symbol,
              style: kButtonText,
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    isAdd = true;
    int x = int.parse(a);
    int y = int.parse(b);
    int c = x + y;
    setState(() {
      result1 = c.toString();
    });
  }

  void subtract() {
    isSubtract = true;
    int x = int.parse(a);
    int y = int.parse(b);
    int c = x - y;
    setState(() {
      result1 = c.toString();
    });
  }

  void multiply() {
    isMultiply = true;
    int x = int.parse(a);
    int y = int.parse(b);
    int c = x * y;
    setState(() {
      result1 = c.toString();
    });
  }

  void divide() {
    isDivide = true;
    int x = int.parse(a);
    int y = int.parse(b);
    int c = x ~/ y;
    setState(() {
      result1 = c.toString();
    });
  }

  void isEqual() {
    solve = true;
    if (isAdd) {
      add();
      isAdd = false;
    }
    if (isSubtract) {
      subtract();
      isSubtract = false;
    }
    if (isMultiply) {
      multiply();
      isMultiply = false;
    }
    if (isDivide) {
      divide();
      isDivide = false;
    }
  }

  void showHistory() {}
  void showFormulas() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SafeArea(
        child: Column(children: [
          //Result Text
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(right: 15.0),
              alignment: Alignment.bottomRight,
              child: Text(
                solve ? result1 : result,
                textAlign: TextAlign.end,
                style: kResultText,
              ),
            ),
          ),

          SizedBox(
            height: 15.0,
          ),

          //Row 1
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        a = '0';
                        b = '0';
                        result = '0';
                        result1 = '0';
                        solve = false;
                        enabled = false;
                      });
                    },
                    onTap: () {
                      setState(() {
                        result = result.substring(0, result.length - 1);
                        b = result;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Color(0xffD6D6D6)),
                      child: Center(
                        child: Text(
                          'AC',
                          style: kButtonText,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Color(0xffD6D6D6)),
                    child: Center(
                      child: Icon(
                        Icons.history,
                        size: 40.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Color(0xffD6D6D6)),
                    child: Center(
                      child: Text(
                        'f(x)',
                        style: kButtonText,
                      ),
                    ),
                  ),
                ),
                buildFunctionButtons('/'),
              ],
            ),
          ),

          //Row 2
          Expanded(
            child: Row(
              children: [
                buildNumberButtons('7'),
                buildNumberButtons('8'),
                buildNumberButtons('9'),
                buildFunctionButtons('x')
              ],
            ),
          ),
          //Row 3
          Expanded(
            child: Row(
              children: [
                buildNumberButtons('4'),
                buildNumberButtons('5'),
                buildNumberButtons('6'),
                buildFunctionButtons('-')
              ],
            ),
          ),

          //Row 4
          Expanded(
            child: Row(
              children: [
                buildNumberButtons('1'),
                buildNumberButtons('2'),
                buildNumberButtons('3'),
                buildFunctionButtons('+')
              ],
            ),
          ),

          //Row 5
          Expanded(
            child: Row(children: [
              buildNumberButtons('0'),
              buildNumberButtons('.'),
              buildFunctionButtons('=')
            ]),
          ),
        ]),
      ),
    );
  }
}
