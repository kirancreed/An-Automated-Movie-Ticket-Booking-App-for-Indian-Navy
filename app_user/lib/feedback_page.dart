import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackPage extends StatefulWidget {
  final String title;

  const FeedbackPage({Key? key, required this.title}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 0;
  bool _isSubmitting = false;
  late int _uid;

  @override
  void initState() {
    super.initState();
    _loadUidFromSharedPreferences();
  }

  // Load uid from SharedPreferences
  Future<void> _loadUidFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = prefs.getInt('U_ID') ?? 0;
    });
  }

  // Submit feedback to API
  Future<void> _submitFeedback() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      Map<String, dynamic> feedbackData = {
        'title': widget.title,
        'feedback': _feedbackController.text,
        'rating': _rating.toString(),
        'uid': _uid,
      };

      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/feedbackapi.php'),
        body: json.encode(feedbackData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Feedback Submitted'),
              content: const Text('Thank you for your feedback!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Navigate back twice
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show error dialog for non-200 status code
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Failed to submit feedback. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'An error occurred while submitting feedback. Please check your network connection and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      // Reset _isSubmitting flag
      setState(() {
        _isSubmitting = false;
      });
    }
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
                    widget.title,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              GradientText(
                text: 'Give Feedback',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade900,
                    Colors.blue.shade300,
                  ],
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Enter your feedback (max 200 words)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              GradientText(
                text: 'Please give your rating',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                gradient: LinearGradient(colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade300,
                ]),
              ),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const SizedBox(height: 25),
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
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: _isSubmitting
                      ? null
                      : () {
                          if (_rating == 0) {
                            // Show alert dialog if rating is not provided
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Rating Required'),
                                  content: const Text(
                                      'Please provide a rating before submitting your feedback.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Submit feedback if rating is provided
                            _submitFeedback();
                          }
                        },
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Submit Feedback',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
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
