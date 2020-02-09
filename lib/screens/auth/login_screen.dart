import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/auth/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _onSuccess() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Usuário criado com sucesso'),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
      });
    }

    void _onFail() {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Falha ao criar usuário'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ))
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    if (value.isEmpty || !value.contains("@"))
                      return "E-mail invalido!";
                    else
                      return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty || value.length < 6)
                      return "Senha invalida";
                    else
                      return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('E-mail não pode estar vazio.'),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);

                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text('Confira seu E-mail'),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        model.signIn(
                            email: _emailController.text,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        }));
  }
}
