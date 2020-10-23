import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  return runApp(MaterialApp(
    home: CalculatorScreen(),
  ));
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  void reset() {
    setState(() {
      answer = "";
      number1.clear();
      number2.clear();
    });
  }

  void choiceAction(String choice) {
    if (choice == Constants.Clear) {
      reset();
    }
  }

  final number1 = TextEditingController();
  final number2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String answer = "";

  void sum() {
    if (_formKey.currentState.validate()) {
      int value1 = int.parse(number1.text);
      int value2 = int.parse(number2.text);
      int result = value1 + value2;

      setState(() {
        answer = '$result';
      });
    }
  }

  void minus() {
    if (_formKey.currentState.validate()) {
      int value1 = int.parse(number1.text);
      int value2 = int.parse(number2.text);
      int result = value1 - value2;

      setState(() {
        answer = '$result';
      });
    }
  }

  void multiply() {
    if (_formKey.currentState.validate()) {
      int value1 = int.parse(number1.text);
      int value2 = int.parse(number2.text);
      int result = value1 * value2;

      setState(() {
        answer = '$result';
      });
    }
  }

  void divide() {
    if (_formKey.currentState.validate()) {
      int value1 = int.parse(number1.text);
      int value2 = int.parse(number2.text);
      double result = value1 / value2;

      setState(() {
        answer = '$result';
      });
    }
  }

  final kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
  );

  final List _images = [
    AssetImage('images/wood 1.jpg'),
    AssetImage('images/wood 2.jpg'),
    AssetImage('images/wood 3.jpg'),
    AssetImage('images/wood 4.jpg'),
    AssetImage('images/wood 5.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'CALCULATOR',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choice.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )),
        ],
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              autoPlay: true,
              enableInfiniteScroll: true,
              autoPlayCurve: Curves.linear,
              autoPlayAnimationDuration: Duration(milliseconds: 500),
            ),
            items: _images.map((i) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: i,
                    fit: BoxFit.cover,
                  )),
                );
              });
            }).toList(),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  'My Answer is',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  answer,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          controller: number1,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: kInputBorder,
                            hintText: 'Enter number',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          controller: number2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: kInputBorder,
                            hintText: 'Enter number',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: () {
                                sum();
                              },
                              child: Text(
                                'ADD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              color: Colors.green,
                              hoverElevation: 5.0,
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: minus,
                              child: Text(
                                'SUB',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              color: Colors.red,
                              hoverElevation: 5.0,
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: multiply,
                              child: Text(
                                'MULT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              color: Colors.blue,
                              hoverElevation: 5.0,
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              onPressed: divide,
                              child: Text(
                                'DIV',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              color: Colors.black,
                              hoverElevation: 5.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
