import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/categoria_screen.dart';

class CategoriaTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoriaTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(snapshot.data['icon'].toString()),
      ),
      title: Text(snapshot.data['title'].toString()),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CategoriaScreen(snapshot))
        );
      },
    );
  }
}