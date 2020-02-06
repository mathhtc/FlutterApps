import 'package:flutter/material.dart';
class Feitas extends StatelessWidget {
  final List  feitas;
  Feitas(this.feitas);

  
  Future<Null> refresh() async{
    await Future.delayed(Duration(seconds: 1));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas feitas"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Text("Tarefas Concluídas, boa!", textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.green, fontSize: 30.0),),
          Divider(),
          Expanded(
           child:ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: feitas.length,
            itemBuilder: buildList,
        ),
        )
        ],
      )
          
        );   
  }

  Widget buildList(context, index){
    return ListTile(
      title: Text("${index+1}. ${feitas[index]["nome"]}", style: TextStyle(color: Colors.green, fontSize: 22.0),
    )
    );

  }
}