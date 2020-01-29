import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

class _HomeState extends State<Home> {
  TextEditingController weightController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  String _message = "Digite seu peso e altura!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _message = "Digite seu peso e altura!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      print(imc);

      if (imc < 18.6) {
        _message = ('Abaixo do peso! ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 18.6 && imc <= 24.9) {
        _message = ('Peso ideal! ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 24.9 && imc <= 29.9) {
        _message = ('Levemente acima do peso... ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 29.9 && imc <= 34.9) {
        _message = ('Obesidade Grau I! ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 34.9 && imc <= 39.9) {
        _message = ('Obesidade Grau II! ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 40) {
        _message = ('Obesidade Grau III! ${imc.toStringAsPrecision(4)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person_outline, size: 120, color: Colors.green),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg):",
                          labelStyle:
                              TextStyle(color: Colors.green, fontSize: 20.0)),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu peso!";
                        }
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura (cm):",
                          labelStyle:
                              TextStyle(color: Colors.green, fontSize: 20.0)),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura!";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) _calculate();
                            // _resetFields();
                          },
                          child: Text(
                            "Calcular",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.00),
                          ),
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Text(_message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.green, fontSize: 25.0))
                  ],
                ))));
  }
}
