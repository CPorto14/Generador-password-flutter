import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generador de contraseñas',
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  bool _usarMayusculas = false;
  bool _usarMinusculas = true;
  bool _usarNumeros = true;
  bool _usarCaracteresEspeciales = false;

  String _contrasenaGenerada = '';

  void _generarContrasena() {
    final random = Random();

    // Caracteres disponibles
    final caracteresMayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final caracteresMinusculas = 'abcdefghijklmnopqrstuvwxyz';
    final caracteresNumeros = '0123456789';
    final caracteresEspeciales = '!@#%^&*()_+';

    // Inicializar caracteres a utilizar
    List<String> caracteres = [];

    if (_usarMayusculas) caracteres.addAll(caracteresMayusculas.split(''));
    if (_usarMinusculas) caracteres.addAll(caracteresMinusculas.split(''));
    if (_usarNumeros) caracteres.addAll(caracteresNumeros.split(''));
    if (_usarCaracteresEspeciales) caracteres.addAll(caracteresEspeciales.split(''));

    // Generar la contraseña
    String contrasena = '';

    for (int i = 0; i < 14; i++) {
      contrasena += caracteres[random.nextInt(caracteres.length)];
    }

    setState(() {
      _contrasenaGenerada = contrasena;
    });

    // Mostrar la contraseña como alerta
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Contraseña generada'),
        content: Text(_contrasenaGenerada),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de contraseñas'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CheckboxListTile(
              title: Text('Mayúsculas'),
              value: _usarMayusculas,
              onChanged: (value) {
                setState(() {
                  _usarMayusculas = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Minúsculas'),
              value: _usarMinusculas,
              onChanged: (value) {
                setState(() {
                  _usarMinusculas = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Números'),
              value: _usarNumeros,
              onChanged: (value) {
                setState(() {
                  _usarNumeros = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Caracteres especiales'),
              value: _usarCaracteresEspeciales,
              onChanged: (value) {
                setState(() {
                  _usarCaracteresEspeciales = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _generarContrasena,
              child: Text('Generar'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contraseña generada:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              _contrasenaGenerada,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

