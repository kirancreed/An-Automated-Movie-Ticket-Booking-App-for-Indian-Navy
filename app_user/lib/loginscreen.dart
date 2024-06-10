import 'fade_in_up_animation.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'terms_condition.dart';

import 'package:shared_preferences/shared_preferences.dart';
//import 'login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isAnimationInitialized = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();

    // Add a delay to automatically navigate after 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      checkUserLoggedIn();
    });

    // Set a flag to indicate that the animation has been initialized
    _isAnimationInitialized = true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAnimationInitialized) {
      return Container(); // Return an empty container while animation is initializing
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 125,
            child: Center(
              child: Image.asset(
                'assets/logo3.png', // Replace with your image asset path
                fit: BoxFit.fill,
              ),
            ),
          ),
          FadeInUpAnimation(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 800),
            child: Container(
              child: AnimatedBuilder(
                animation: _animationController,
                child: Center(
                  child: GradientText(
                    text: 'Navy Welfare',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade300,
                    ]),
                  ),
                ),
                builder: (context, child) => Opacity(
                  opacity: _animation.value,
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getInt('U_ID');
    if (_userLoggedIn == null || _userLoggedIn == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TermsAndConditionsPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
    required this.text,
    this.style,
    required this.gradient,
  }) : super(key: key);
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
