import 'package:flutter/material.dart';
import 'dart:async'; // Para usar Timer

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Inicia o Timer para navegar para a próxima tela após 3 segundos
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home'); // Rota para a página inicial
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/src/assets/images/image.png', width: 300), 
            SizedBox(height: 20),
            CircularProgressIndicator(), 
          ],
        ),
      ),
    );
  }
}
