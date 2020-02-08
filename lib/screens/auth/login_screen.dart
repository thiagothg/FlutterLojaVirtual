import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SignUpScreen())
              );
            }, 
            child: Text("Criar Conta",
              style: TextStyle(
                fontSize: 15
              ),
            )
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
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

            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: (){
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(builder: (context) => SignUpScreen())
                  // );
                }, 
                child: Text("Esqueci minha senha",
                  textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(height: 16),

            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){

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