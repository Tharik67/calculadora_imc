import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightcontroler = TextEditingController();
  TextEditingController heightcontroler = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _inftext = 'Informe seus dados';

  void _resetFields() {
    weightcontroler.text = '';
    heightcontroler.text = '';
    setState(() {
      _inftext = 'Informe seus dados';
      _formkey = GlobalKey<FormState>();
    });
  }

  void calcula() {
    setState(() {
      double weight = double.parse(weightcontroler.text);
      double heigth = double.parse(heightcontroler.text) / 100;
      double imc = weight / (heigth * heigth);
      if (imc < 18.6) {
        _inftext = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc < 24.9 && imc >= 18.6) {
        _inftext = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc < 34.9 && imc >= 24.9) {
        _inftext = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc < 39.9 && imc >= 34.9) {
        _inftext = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _inftext = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      } else {
        _inftext = 'sei la';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculador de Imc'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.autorenew),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white, Colors.blue[200]])),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_pin, size: 120, color: Colors.blue[900]),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso em kg:',
                      labelStyle:
                          TextStyle(fontSize: 25, color: Colors.black87)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 25.0),
                  controller: weightcontroler,
                  validator: (String value) {
                    return value.isEmpty ? 'Isira sua altura' : null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura em cm:',
                      labelStyle:
                          TextStyle(fontSize: 25, color: Colors.black87)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 25.0),
                  controller: heightcontroler,
                  validator: (String value) {
                    return value.isEmpty ? 'Isira sua altura' : null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              calcula();
                            }
                          },
                          child: Text(
                            'Calcular',
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.blue[900])),
                ),
                Container(
                  height: 50.0,
                  child: Text(_inftext,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 25.0)),
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ));
  }
}
