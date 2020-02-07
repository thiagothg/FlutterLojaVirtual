import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/produto_data.dart';
import 'package:loja_virtual/screens/produto_screen.dart';

class ProdutoTile extends StatelessWidget {

  final String type;
  final ProdutoData produto;

  ProdutoTile(this.type, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProdutoScreen(produto))
        );
      },
      child: Card(
        child: type == 'grid' ? 
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(produto.images[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(produto.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('R\$ ${produto.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),

                      )
                    ],
                  ),
                ),
              ),
            ],
          )
         : Row(
           children: <Widget>[
             Flexible(
               flex: 1,
               child: Image.network(produto.images[0], 
                fit: BoxFit.cover,
                height: 250,
              ),
             ),

             Flexible(
               flex: 1,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(produto.title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                   ),
                   Text("R\$ ${produto.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                   )
                 ],
               ),
             )
           ],
         ),
      ),
    );
  }
}