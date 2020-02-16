import 'package:flutter/material.dart';
import 'package:calculator/stream_bloc.dart';
void main(){

  runApp(MaterialApp(
    home: Calculator()
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  CalculatorResult calculator = CalculatorResult();


  Expanded buildButton(String buttonText){
    return Expanded(
          child: SizedBox(
            height: 70.0,
            child:
              RaisedButton(
              child: Text(buttonText),
              onPressed: (){
                calculator.inputExpression(buttonText);
              },
      ),
          )
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text("Calculadora", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.grey[400],

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child :
                Container(
                  width: double.infinity,
                  height: 80,
                  child: Center(
                    child: 
                      StreamBuilder(
                        stream: calculator.output,
                        builder: (context, snapshot){
                        return Text(
                          calculator.problem, style: TextStyle(fontSize: 22.0),
                            );}
                    ),
                  )
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  height: 0.0,
                  width: 272.0,
                ),
                SizedBox(
                  height: 50.0,
                 child: RaisedButton(
                    onPressed: calculator.eraseOne,
                    child: Icon(Icons.clear),
                    ),
                )
            ],),
            Row(
                children: <Widget>[
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('+'),
                ]
              ),
            
             Row(
                children: <Widget>[
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('-'),
                ],
              ),
            
             Row(
                children: <Widget>[
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('*'),
                  ],
                ),
            
             Row(
           
                children: <Widget>[
                  Expanded(
                    child: 
                    SizedBox(
                      height: 70.0,
                      child: RaisedButton(
                        onPressed: (){
                          calculator.clearText();   
                        },
                        child: Text('AC'),
                      ),
                    ),
                  ),
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('/'),
                  Expanded(
                    child: SizedBox(
                      height: 70.0,
                      child: RaisedButton(
                        child: Text("="),
                        onPressed: (){
                          calculator.inputSolution();
                        }
                      ),
                    ),
                  ),
                  ],
              ),
          ],
        ),
      ),
    );          
  }
}

