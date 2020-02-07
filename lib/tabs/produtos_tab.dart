import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/categoria_title.dart';

class ProdutosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('products').getDocuments(),
      builder: (context, snapshot){
        
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator(),);
        }
        else
        {
          var dividedTitles = ListTile.divideTiles(
              tiles: snapshot.data.documents.map((doc) {
              return CategoriaTile(doc);
            }), 
            color: Colors.green[500]
          ).toList();

          return ListView(
            children: dividedTitles,
          );
        }
      },
    );
  }
}