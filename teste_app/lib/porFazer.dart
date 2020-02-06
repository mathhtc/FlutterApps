import 'package:flutter/material.dart';


class PorFazer extends StatelessWidget {
  List nFeitas = List();
  PorFazer(this.nFeitas);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Por Fazer"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Text("Ih, macho. Avia aí", textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.orange, fontSize: 30.0),),
          Divider(),
          Expanded(
           child:ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: nFeitas.length,
            itemBuilder: buildList,
        ),
        )
        ],
      )
          
    );   
  }

  Widget buildList(context, index){
    return ListTile(
      title: Text("${index+1}. ${nFeitas[index]["nome"]}", style: TextStyle(color: Colors.orange, fontSize: 22.0),
    )
    );

  }
}