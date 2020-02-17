import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  bool isLoadding = false;
  String coupomCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if(user.isLoggedIn()) {
      _loadCartitem();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct product) {
    products.add(product);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(product.toMap())
        .then((doc) {
      product.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(product.cid)
        .delete();

    products.remove(product);

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity ++;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .document(cartProduct.cid).updateData(cartProduct.toMap());
    
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity --;
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart")
    .document(cartProduct.cid).updateData(cartProduct.toMap());
    
    notifyListeners();
  }

  void _loadCartitem() async {
   QuerySnapshot query = await Firestore.instance.collection("users")
    .document(user.firebaseUser.uid)
    .collection("cart")
    .getDocuments();

    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPorcentage) {
    this.coupomCode = coupomCode;
    this.discountPercentage = discountPorcentage;
  }

  double getProductsPrice () {
    double price = 0.0;

    for(CartProduct c in products) {
      if(c.produtoData != null) {
        price += c.quantity * c.produtoData.price;
      }
    }

    return price;
  }

  double getDiscount () {
   return  getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice () {
    return 9.99;
  }

  void updatePrice () {
    notifyListeners();
  }
}
