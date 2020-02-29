import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/auth/login_screen.dart';
import 'package:loja_virtual/tiles/order_tile.dart';

class OrderTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    if(UserModel.of(context).isLoggedIn()) {
        String uid = UserModel.of(context).firebaseUser.uid;
        print('teste');
        return FutureBuilder<QuerySnapshot> (
          future: Firestore.instance.collection("users").document(uid)
          .collection("orders").getDocuments(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              print(snapshot.data.documents.length);
              return ListView(
                children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList(),
              );
            }
          },
        );

    } else {

       return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Faça o login para adicionar produtos!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen()));
              },
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
    }
  }
}
