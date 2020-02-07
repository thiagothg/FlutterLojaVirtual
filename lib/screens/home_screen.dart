import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/produtos_tab.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          body: ProdutosTab(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            centerTitle: true,
          ),
          body: Container(),
          drawer: CustomDrawer(_pageController),
        ),

        Scaffold(
          appBar: AppBar(
            title: Text('Meus Produtos'),
            centerTitle: true,
          ),
          body: Container(),
          drawer: CustomDrawer(_pageController),
        ),        
      ],
    );
  }
}