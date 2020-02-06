import 'package:flutter/material.dart';
import 'package:teste_app/feitas.dart';
import 'package:async/async.dart';
import 'package:teste_app/porFazer.dart';
void main() {
  runApp(MaterialApp(
    home: HomePage()
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tarefas = List();
  Map<String, dynamic> lastR = Map();
  int lastP;
  TextEditingController listController = TextEditingController();

List soFeitas(tarefas){
      List feitas = List();
    for(int i = 0; i<tarefas.length ; i++){
      if(tarefas[i]["ja"]){
        feitas.add(tarefas[i]);
      }
    }
    return feitas;
  }
  List nFeitas(tarefas){
    List nFeitas = List();
    for(int i = 0; i<tarefas.length ; i++){
      if(!tarefas[i]["ja"]){
        nFeitas.add(tarefas[i]);
      }
    }
    return nFeitas;
  }
void addTarefa(){
    Map<String, dynamic> toDoMap = Map();
    setState((){
    toDoMap["nome"] = listController.text;
    listController.text = "";
    toDoMap["ja"] = false;
    tarefas.add(toDoMap);
    });
  }  
  Future<Null> refresh() async{
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rodou, humilde"),
        backgroundColor: Colors.green,
        actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.assignment_late),
                label: Text(""),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PorFazer(nFeitas(tarefas))));
                },
            ),
            FlatButton.icon(
                icon: Icon(Icons.airline_seat_recline_extra),
                label: Text("",),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => Feitas(soFeitas(tarefas)) ));
                },
            )
        ] 
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Diz a tarefa aí:",
                  border: OutlineInputBorder()
                ),
                onSubmitted: (text){
                  addTarefa();
                },
              controller: listController,
            ),),
            Divider(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: tarefas.length,
                  itemBuilder: daleDaleDaleOOOO,
            )
            ))
          ],
        ),); 
  }

  Widget daleDaleDaleOOOO(context, index){
    return Dismissible(
        background: Container(
          color: Colors.red,
        ),
        direction: DismissDirection.startToEnd,
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        child: CheckboxListTile(
          title: Text(tarefas[index]["nome"]),
          value: tarefas[index]["ja"],
          onChanged: (s){
            setState(() {
            tarefas[index]["ja"] = s;  
            });
          },
        secondary: CircleAvatar(
          child: Icon(tarefas[index]["ja"] ? Icons.alarm_on : Icons.whatshot, ) ,
        ),
        ),
      onDismissed: (direction){
        setState(() {
        lastR = Map.from(tarefas[index]);
        lastP = index;
        tarefas.removeAt(index);
      
        final snack =  SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Se liga, tarefa ${lastR["nome"]} retirada"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: (){
              setState(() {
                tarefas.insert(lastP,lastR);
              });
            },
          ),
        );
        Scaffold.of(context).showSnackBar(snack);
        });
        }
    );
    }
    
  }

