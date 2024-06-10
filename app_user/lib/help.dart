import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Import this package for AssetImage
import 'constant.dart'; // Import your constant file

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  late String phoneNumber = ''; // Variable to store phone number
  late http.Client httpClient;

  @override
  void initState() {
    super.initState();
    httpClient = http.Client();
    _fetchContactInfo(); // Call method to fetch contact info from API
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  void _fetchContactInfo() async {
    try {
      final response =
          await httpClient.get(Uri.parse('${ApiConstants.baseUrl}contact.php'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final Map<String, dynamic> contactInfo = data.first;
          print(contactInfo);
          setState(() {
            phoneNumber = contactInfo['phone_no'].toString();
          });
        } else {
          // Handle empty response
          print('Empty response body');
        }
      } else {
        // Handle error if API call fails
        print('Failed to fetch contact info');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception: $e');
    }
  }

  @override
  void dispose() {
    httpClient.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade800,
                      Colors.blue.shade400,
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeTransition(
              opacity: _fadeInAnimation,
              child: GradientText(
                text: 'Frequently Asked Questions (FAQs)',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                gradient: LinearGradient(colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade400,
                ]),
              ),
            ),
            const SizedBox(height: 10.0),
            FaqItem(
              question: 'How do I purchase tickets?',
              answer:
                  'To purchase tickets, simply browse through the list of available movies, select the movie you want to watch, choose the showtime, select your seats, and conform ticket.',
              animationDelay: 0.2,
            ),
            FaqItem(
              question: 'Can I cancel tickets?',
              answer:
                  'You can cancel your ticket before 15 minutes of the showtime by navigating to the View Tickets section.',
              animationDelay: 0.4,
            ),
            FaqItem(
              question: 'How do I change my account password?',
              answer:
                  'You can update your account information by navigating to the profile section of the app. From there, you can edit your password.',
              animationDelay: 0.8,
            ),
            const SizedBox(height: 20.0),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: GradientText(
                text: 'Contact Support',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                gradient: LinearGradient(colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade300,
                ]),
              ),
            ),
            const SizedBox(height: 10.0),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: const Text(
                  'If you need further assistance, please feel free to contact admin:',
                  style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(height: 10.0),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Text('Phone: $phoneNumber',
                  style: const TextStyle(color: Colors.black87)),
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;
  final double animationDelay;

  FaqItem(
      {required this.question,
      required this.answer,
      required this.animationDelay});

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _heightFactorAnimation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightFactorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpansion,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                RotationTransition(
                  turns: _expandController.drive(Tween(begin: 0.0, end: 0.5)),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _heightFactorAnimation,
              axisAlignment: -1.0,
              child: FadeTransition(
                opacity: _heightFactorAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                      textAlign: TextAlign.justify,
                      widget.answer,
                      style: const TextStyle(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
