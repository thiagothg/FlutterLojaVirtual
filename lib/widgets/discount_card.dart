import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text("Cupom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).coupomCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance.collection("coupons").document(text).get().then((result){
                  if(result.data != null) {
                    
                    CartModel.of(context).setCoupon(text, result.data['percent']);

                    Scaffold.of(context).showSnackBar(
                      SnackBar( 
                        content: Text("Desconto de ${result.data["percent"]}% aplicado!"),
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    );
                  } else {
                    CartModel.of(context).setCoupon(null, null);

                     Scaffold.of(context).showSnackBar(
                      SnackBar( 
                        content: Text("Cupom não existe!"),
                        backgroundColor: Colors.redAccent,
                      )
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
