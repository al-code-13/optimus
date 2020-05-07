import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

final databaseReference = Firestore.instance;
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();
bool boolValue;
String familia;
String nombre;
String apellido;
String cedula;
int edad;
double temperatura;
double _value = 39;
bool activarBoton;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    boolValue = false;

    super.initState();
  }

  void _setvalue(double value) => setState(() => _value = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnóstico"),
        backgroundColor: Color.fromARGB(225, 239, 75, 26),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://www.lapatria.com/sites/default/files/styles/620x/public/imagenprincipal/2015/Abr/casa2.jpg"),
                  ),
                ),
              ),
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
                    SizedBox(height: 10.0),
                    _crearNombre(),
                    SizedBox(height: 20.0),
                    _crearApellido(),
                    SizedBox(height: 20.0),
                    _crearCedula(),
                    SizedBox(height: 20.0),
                    _crearEdad(),
                    SizedBox(height: 20.0),
                    _crearFamilia(),
                    SizedBox(height: 10.0),
                    _crearTemp(),
                    _crearBoton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createRecord(BuildContext context) async {
    DocumentReference ref = await databaseReference.collection("users").add({
      'nombre': '$nombre',
      'apellido': '$apellido',
      'cedula': '$cedula',
      'edad': edad,
      'temp': '$temperatura',
      'familiar': boolValue ? "Si" : "No",
    });
    setState(() {
      controller1.clear();
      controller2.clear();
      controller3.clear();
      controller4.clear();
      controller5.clear();
      nombre = null;
      apellido = null;
      cedula = null;
      edad = null;
      temperatura = null;
      boolValue = false;
    });
    print(ref.documentID);
    _showToast(context);
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller1,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Color.fromARGB(225, 239, 75, 26)),
          labelText: 'Nombre',
        ),
        onChanged: ((value) {
          nombre = value;
          print(value);
        }),
      ),
    );
  }

  void _showToast(BuildContext context) {
    Fluttertoast.showToast(
        msg: "Registro Exitoso!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(225, 239, 75, 26),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _crearApellido() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller2,
        decoration: InputDecoration(
          icon: Icon(Icons.person, color: Color.fromARGB(225, 239, 75, 26)),
          labelText: 'Apellido',
        ),
        onChanged: ((value) {
          apellido = value;
          print(value);
        }),
      ),
    );
  }

  Widget _crearFamilia() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Familiar enfermo?"),
          Checkbox(
            value: boolValue,
            onChanged: (bool value) {
              setState(() {
                boolValue = value;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _crearCedula() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller3,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.chrome_reader_mode,
              color: Color.fromARGB(225, 239, 75, 26)),
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
        controller: controller4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.assignment_ind,
              color: Color.fromARGB(225, 239, 75, 26)),
          labelText: 'Edad',
        ),
        onChanged: ((value) {
          edad = int.parse(value);
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
            new Text('Temperatura: ${(_value).round()}'),
            new Slider(
              activeColor: Color.fromARGB(225, 239, 75, 26),
              value: _value,
              onChanged: _setvalue,
              divisions: 12,
              min: 30.0,
              max: 42.0,
              onChangeEnd: (value) {
                temperatura = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    activarBoton = nombre != null && apellido != null && cedula != null && edad != null;
    setState(() {
      
    });
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Color.fromARGB(225, 239, 75, 26),
      textColor: Colors.white,
      onPressed: activarBoton 
          ? () {
              createRecord(context);
            }
          : null,
    );
  }
}
