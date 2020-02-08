import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

class SignUpScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: "Nome Completo"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if(value.isEmpty) return "Nome invalido!"; else return null;
              },
            ),
            SizedBox(height: 16,),

            TextFormField(
              decoration: InputDecoration(
                hintText: "Endereco"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if(value.isEmpty) return "Endereco invalido!"; else return null;
              },
            ),
            SizedBox(height: 16,),

            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if(value.isEmpty || !value.contains("@")) return "E-mail invalido!"; else return null;
              },
            ),
            SizedBox(height: 16,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Senha"
              ),
              obscureText: true,
              validator: (String value) {
                if(value.isEmpty || value.length < 6) return "Senha invalida"; else return null;
              },
            ),

            SizedBox(height: 16),

            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                   Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen())
                  );
                }
              },
              child: Text("Entrar",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}