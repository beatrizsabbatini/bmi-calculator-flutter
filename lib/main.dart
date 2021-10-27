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

  String _message = "Digite seu peso e altura";
  String _resultMessage = "";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _message = "Digite seu peso e altura";
      _resultMessage = "";
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
        _resultMessage = ('Abaixo do peso! Seu IMC é: ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 18.6 && imc <= 24.9) {
        _resultMessage = ('Peso ideal! Seu IMC é: ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 24.9 && imc <= 29.9) {
        _resultMessage = ('Levemente acima do peso... Seu IMC é: ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 29.9 && imc <= 34.9) {
        _resultMessage = ('Obesidade Grau I! Seu IMC é: ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 34.9 && imc <= 39.9) {
        _resultMessage = ('Obesidade Grau II! Seu IMC é: ${imc.toStringAsPrecision(4)}');
      } else if (imc >= 40) {
        _resultMessage = ('Obesidade Grau III!Seu IMC é:  ${imc.toStringAsPrecision(4)}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Image.asset(
              "images/background.png",
              fit: BoxFit.cover,
              height: 1000.0,
            ),
            SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 5),
                            child: Image(
                              image: AssetImage('images/workout.png'),
                              height: 220,
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(_message, textAlign: TextAlign.center, style: TextStyle(color: Colors.deepPurpleAccent[200], fontSize: 25.0, fontWeight: FontWeight.w300)),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)), labelText: "Peso (kg):", labelStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                          textAlign: TextAlign.center,
                          controller: weightController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira seu peso!";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)), labelText: "Altura (cm):", labelStyle: TextStyle(color: Colors.grey, fontSize: 20.0)),
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                          textAlign: TextAlign.center,
                          controller: heightController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira sua altura!";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Container(
                            height: 50.0,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) _calculate();
                              },
                              child: Text(
                                "Calcular",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 25.00, fontWeight: FontWeight.w400),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent[400]),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Text(_resultMessage, textAlign: TextAlign.center, style: TextStyle(color: Colors.deepPurpleAccent[200], fontSize: 25.0, fontWeight: FontWeight.w600)),
                        )
                      ],
                    )))
          ],
        ));
  }
}
