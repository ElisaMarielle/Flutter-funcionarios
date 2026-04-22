import 'package:flutter/material.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _direitaCentro, _centroEsquerda;
  double _x = -400;
  @override
  void initState() {
    super.initState();
    movimentos();
    entrada();
  }

  void movimentos() {
    _direitaCentro =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() {
            setState(() {
              _x = -400 + 400 * _direitaCentro.value;
            });
          });
    _centroEsquerda =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addListener(() {
            setState(() {
              _x = 0 - 400 * _centroEsquerda.value;
            });
          });
  }

  void resetAnimation() {
    _direitaCentro.reset();
    setState(() {
      _x = -400;
    });
  }

  void entrada() {
    _direitaCentro.forward();
  }

  void saida() {
    _centroEsquerda.forward();
  }

  void irParaHome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );

    resetAnimation();
    entrada();
  }

  @override
  void dispose() {
    _direitaCentro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Funcionários da empresa")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            Transform.translate(
              offset: Offset(_x, 0),
              child: Image.asset('assets/empresa.png', width: 150),
            ),
            ElevatedButton(onPressed: irParaHome, child: Text("Entrar")),
          ],
        ),
      ),
    );
  }
}
