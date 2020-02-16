import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';

class CalculatorResult extends BlocBase{
  final controller = StreamController();
  String problem = '';

  Stream get output => controller.stream;
  Sink get input => controller.sink;


  void inputExpression(buttonText){
    problem = problem + buttonText;
    input.add(problem);
  }
  void eraseOne(){
    if(problem.isNotEmpty){
      String aux = problem;
      problem = '';
      int i = 0;
      while(i<aux.length -1){
        problem = problem + aux[i];
        i++;
      }
      input.add(problem);
    }
  }
  void inputSolution(){
    problem = solveProblem();
    input.add(problem);
  }

  void clearText(){
    problem = '';
    input.add(problem);
  }

  String solveProblem(){
    String aux = '';
    List<double> numeros = List();
    List<String> opList = List();
    int j = 0;
    int i  = 0;
    while(i<problem.length){
      if(problem[i] == '+' || problem[i] == '-' || problem[i] == '*' || problem[i] == '/'){
        numeros.add(double.parse(aux));
        aux = '';
        opList.add(problem[i]);
        i++;
      }
      else{
      aux = aux + problem[i];
      i++;
      }
    }
    numeros.add(double.parse(aux));

    if(opList.length  < numeros.length){
      j = opList.length -1;

      while(j>= 0){
          if(opList[j] == '/'){
            if(numeros[j+1] != 0){
              numeros[j] = numeros[j]/numeros[j+1];
              numeros.removeAt(j+1);
              opList.removeAt(j);
            }
            else{
              return 'Perdeu o juízo?';
            }
          }
          else if(opList[j] == '*'){
            numeros[j] = numeros[j]*numeros[j+1];
            numeros.removeAt(j+1);
            opList.removeAt(j);
          }
          j--;
        }
        i = opList.length - 1;
      while(i>=0){
        
        if(opList[i] == '+'){
          numeros[i] = numeros[i] + numeros[i+1];
          numeros.removeAt(i+1);
          opList.removeAt(i);
        }
        else if(opList[i] == '-'){
          numeros[i] = numeros[i] - numeros[i+1]; 
          numeros.removeAt(i+1);
          opList.removeAt(i);
        }
        i--; 
      }  
      
    }
    else{
      return 'Tá doido, é?';
      }
    return ('${numeros.last}');
  }
  @override
  void dispose(){
    controller.close();
  }
}