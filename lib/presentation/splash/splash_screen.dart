import 'package:flutter/material.dart';
import 'package:gadajaleostroznie/presentation/menu/menu_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () { //6
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MenuScreen(),
            transitionsBuilder: (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: FadeTransition(
        opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        child: Center(
          child: Text("Badass\nEKRAN", textAlign: TextAlign.center, style: TextStyle(fontSize: 50))
        ),
      ),
    );
  }
}
