// Punto de entrada principal de la app TMB.
// Configuramos MaterialApp con la pantalla inicial TmbScreen.
import 'package:flutter/material.dart';
import '../screens/tmb_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TmbScreen(),
  ));
}

