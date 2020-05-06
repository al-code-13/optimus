import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
final databaseReference = Firestore.instance;
String nombre;
String apellido;
String cedula;
int edad;
double temperatura;
double _value = 39;

class _HomePageState extends State<HomePage> {
  void _setvalue(double value) => setState(() => _value = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnóstico"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
             
              Container(
                width: 300,
                margin: EdgeInsets.symmetric(vertical: 30.0),
                padding: EdgeInsets.symmetric(vertical: 50.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3.0,
                          offset: Offset(0.0, 5.0),
                          spreadRadius: 3.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Text('Registro', style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 60.0),
                    _crearNombre(),
                    SizedBox(height: 30.0),
                    _crearPassword(),
                    SizedBox(height: 30.0),
                    _crearCedula(),
                    SizedBox(height: 30.0),
                    _crearEdad(),
                    SizedBox(height: 20.0),
                    _crearTemp(),
                    SizedBox(height: 20.0),
                    _crearBoton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void createRecord() async {
  // await databaseReference.collection("users")
  //     .document("1")
  //     .setData({
  //       'name': '$nombre',
  //       'apellido': '$apellido',
  //       'cedula':'$cedula',
  //       'edad': '$edad'
  //     });

  DocumentReference ref = await databaseReference.collection("users")
      .add({
        'nombre': '$nombre',
        'apellido': '$apellido',
        'cedula':'$cedula',
        'edad': edad,
        'temp': '$temperatura'
      }).then((onValue){
        print(onValue);
      });
  print(ref.documentID);
}
  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.deepPurple),
          labelText: 'Nombre',
        ),
        onChanged: ((value) {
          nombre = value;
          print(value);
        }),
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Colors.deepPurple),
          labelText: 'Apellido',
        ),
        onChanged: ((value) {
          apellido = value;
          print(value);
        }),
      ),
    );
  }

  Widget _crearCedula() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.chrome_reader_mode, color: Colors.deepPurple),
          labelText: 'Cedula',
        ),
        onChanged: ((value) {
          cedula = value;
          print(value);
        }),
      ),
    );
  }

  Widget _crearEdad() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.assignment_ind, color: Colors.deepPurple),
          labelText: 'Edad',
        ),
        onChanged: ((value) {
          edad  =int.parse(value);
          print(value);
        }),
      ),
    );
  }

  Widget _crearTemp() {
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Text('Value: ${(_value).round()}'),
            new Slider(
              value: _value,
              onChanged: _setvalue,
              divisions: 12,
              min: 30.0,
              max: 42.0,
              onChangeEnd: (value){
                temperatura = value ;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {createRecord();},
    );
  }
}
