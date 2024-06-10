import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fade_in_up_animation.dart';
import 'register.dart';
import 'loginscreen.dart';
import 'homepage.dart';
import 'constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RealLoginScreen extends StatefulWidget {
  const RealLoginScreen({Key? key}) : super(key: key);

  @override
  _RealLoginScreenState createState() => _RealLoginScreenState();
}

class _RealLoginScreenState extends State<RealLoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _mobnoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _phoneNumberValid = true; // Track the validity of the phone number
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          AnimatedBuilder(
                            animation: _animationController,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: GradientText(
                                text: 'Let\'s Sign You In',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
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
                          const SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            color: _phoneNumberValid ? Colors.grey : Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              keyboardType: TextInputType.phone,
                              controller: _mobnoController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your phone number...',
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(
                            color: _phoneNumberValid ? Colors.grey : Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your password...',
                                  hintStyle:
                                      TextStyle(fontWeight: FontWeight.w400)),
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade800,
                              Colors.blue.shade200,
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Log in',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                FadeInUpAnimation(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void login() async {
    String url = "${ApiConstants.baseUrl}login.php";
    final Map<String, dynamic> queryParams = {
      "mobno": _mobnoController.text,
      "password": _passwordController.text,
    };
    try {
      setState(() {
        _phoneNumberValid = true; // Reset validity state
        _errorMessage = null; // Reset error message
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          title: Text("Logging In"),
          content: CircularProgressIndicator(),
        ),
      );

      Uri myUri = Uri.parse(url);
      http.Response response =
          await http.get(myUri.replace(queryParameters: queryParams));
      Navigator.pop(context);

      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);

        if (responseData.isNotEmpty) {
          Map<String, dynamic> firstData = responseData.first;

          if (firstData.containsKey('STATUS')) {
            int status = firstData['STATUS'];
            if (status == 1 || status == 2) {
              // Successful login
              final sharedPrefs = await SharedPreferences.getInstance();
              sharedPrefs.setString('NAME', firstData['NAME']);
              sharedPrefs.setString('RANK', firstData['RANK']);
              sharedPrefs.setInt('U_ID', firstData['U_ID']);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else if (status == 0) {
              // Show message for waiting or successful login
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Please Wait"),
                  content: const Text("Your request is being processed."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            } else if (status == -1) {
              // Show message to contact admin
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Contact Admin"),
                  content: const Text("Please contact the administrator."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            }
          } else {
            // Handle case when no 'STATUS' is returned
            setState(() {
              _phoneNumberValid = false;
              _errorMessage =
                  "Invalid phone number or password.Please registerif you are a new user.";
            });
          }
        } else {
          setState(() {
            _phoneNumberValid = false;
            _errorMessage = "Invalid phone number or password";
          });
        }
      } else {
        // Show error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to login. Error "),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Show exception message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Exception"),
          content: Text("Somthing went wrong please try again."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
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
