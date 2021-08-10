import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();
  String _infoText = 'Informe seus dados';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: resetFields, icon: Icon(Icons.refresh)),
        ],
        backgroundColor: Colors.deepPurple,
        //Deixa o titile da appbar no meio
        centerTitle: true,
        title: Text(
          'Calculadora de IMC',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.person_pin_rounded,
              size: 120.0,
              color: Colors.deepPurple,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _pesoController,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          labelText: "Peso (kg)",
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 20)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _alturaController,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          labelText: "Altura (cm)",
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 20)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 13),
                      child: SizedBox(
                        width: 140,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: calculate,
                          child: Text('Calcular'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _infoText,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetFields() {
    _alturaController.text = "";
    _pesoController.text = "";
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void calculate() {
    setState(() {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }
}
