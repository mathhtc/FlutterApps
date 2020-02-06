import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //para acessar a API do conversor
import 'dart:async';
import 'dart:convert'; //para converter para json e poder usar os dados


const request = "https://api.hgbrasil.com/finance?key=d01f1120";

void main() async{
    
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.green,
      primaryColor: Colors.green
    ) ,  //Lembrar sempre dessas demarcações home, body..
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  TextEditingController realController = TextEditingController();
  double dolar;
  double euro;

void realChange(String texto){
  double real = double.parse(texto);
  dolarController.text = (real/dolar).toStringAsFixed(2);
  euroController.text = (real/euro).toStringAsFixed(2);
}
void dolarChange(String texto){
  double dolar = double.parse(texto);
  realController.text = (dolar * this.dolar).toStringAsFixed(2);
  euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
}
void euroChange(String texto){
  double euro = double.parse(texto);
  realController.text = (euro* this.euro).toStringAsFixed(2);
  dolarController.text = (euro* this.euro / dolar).toStringAsFixed(2);
}
void resetFields(){
  //setState(() {
  realController.text = "";
  euroController.text = "";
  dolarController.text = "";  
  //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Conversor de Moedas",style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.white,),
          onPressed:(){ resetFields();},
        )]
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando dados", style: TextStyle(color: Colors.greenAccent, 
                fontSize: 30.0),textAlign: TextAlign.center,),
              );
            default:
              if(snapshot.hasError){
                return Center(
                  child: Text("Erro ao carregar dados", style: TextStyle(color: Colors.red, 
                  fontSize: 30.0),textAlign: TextAlign.center,),
                );
              }else{
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(//Tela Scrollavel de 1 filho, para podermos mexer 
                //verticalmente a tela e o teclado não cobrir os dados
                  padding: EdgeInsets.all(10.0), //esse padding "pega" pra todos os descendentes de Single
                  child: Column( //Usamos coluna pois todos os nossos campos vão estar alinhados verticalmente
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150, color: Colors.green,),
                      Divider(),
                      buildTextField("Reais", "R\$", realController, realChange),
                      Divider(),
                      buildTextField("Dólares", "U\$", dolarController, dolarChange),
                      Divider(),
                      buildTextField("Euro", "€", euroController, euroChange),
                  ],
                ),
              );
             } 
          }
        },
    ));
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controller, Function f){
  return TextField(keyboardType: TextInputType.number,//textfield para o cliente entrar com os dados
            //keyboardType para delimitar o tipo de teclado que vai aparecer
            controller: controller,
            decoration: InputDecoration( //decoração do text field
              labelText: label,
              labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
              prefixText: "$prefix ",
              border: OutlineInputBorder()
            ),
          onChanged: f,
          );
}

Future<Map> getData() async{
  http.Response response = await http.get(request); //pra pegar os dados e "esperar" eles chegarem
  //o await é o que parece e por isso tem o async na delcaração do main
  return json.decode(response.body); //Essa formatação é devido o modo
  //de agrupar os dados do json, parecido com as pastas do windows

}