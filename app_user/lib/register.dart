import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constant.dart';

import 'fade_in_up_animation.dart';
import 'login.dart';
import 'package:flutter/services.dart'; // Add import for TextInputFormatter

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController navyNoController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? _selectedRankCategory;
  String? _selectedRank;
  final _formKey = GlobalKey<FormState>();

  final Map<String, List<String>> _rankCategories = {
    'Army': [
      'Brigadier',
      'Colonel',
      'Lieutenant Colonel',
      'Major',
      'Captain',
      'Lieutenant',
      'Subedar Major',
      'Subedar',
      'Naib Subedar',
      'Lance Havildar',
      'Naik',
      'Lance Naik',
      'Soldier/Gunner/Sepoy',
    ],
    'Air Force': [
      'Air Commodore',
      'Group Captain',
      'Wing Commander',
      'Squadron Leader',
      'Flight Lieutenant',
      'Flying Officer',
      'Master Warrant officer',
      'Warrant officer',
      'Junior Warrant officer',
      'Sergeant',
      'Corporal',
      'Leading Aircraftsman',
      'Airman',
    ],
    'Navy': [
      'Commodore',
      'Captain',
      'Commander',
      'Lieutenant Commander',
      'Lieutenant',
      'Sub Commander',
      'Master Chief Petty Officer (First Class)',
      'Master Chief Petty Officer (Second Class)',
      'Chief Petty Officer',
      'Petty Officer',
      'Leading Seaman',
      'Seaman 1',
      'Seaman 2 (Sailor)',
    ],
    'Others': ['Others'],
  };

  @override
  void dispose() {
    nameController.dispose();
    navyNoController.dispose();
    unitController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUpAnimation(
                      duration: Duration(milliseconds: 1000),
                      child: GradientText(
                        text: "Sign up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        gradient: LinearGradient(colors: [
                          Colors.blue.shade900,
                          Colors.blue.shade300,
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1200),
                      child: Text(
                        "Create an account",
                        style: TextStyle(
                            fontSize: 15, color: Colors.blue.shade300),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    makeDropDownCategory(label: "Rank Category"),
                    if (_selectedRankCategory != null)
                      makeDropDownRanks(label: "Rank"),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Name",
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name.';
                            }
                            return null;
                          }),
                    ),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Navy No",
                          controller: navyNoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Navy number.';
                            }
                            return null;
                          }),
                    ),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Unit",
                          controller: unitController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your unit.';
                            }
                            return null;
                          }),
                    ),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Mobile No",
                          controller: mobileNoController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number.';
                            } else if (value.length != 10) {
                              return 'Please enter a valid 10 digit mobile number.';
                            }
                            return null;
                          },
                          phoneNumber: true), // Set phoneNumber to true
                    ),
                    FadeInUpAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: makeInput(
                          label: "Password",
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password.';
                            } else if (value.length < 3) {
                              return 'Password must be at least 3 characters long.';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
                FadeInUpAnimation(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade800,
                          Colors.blue.shade200,
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedRankCategory != null &&
                            _selectedRank != null &&
                            _formKey.currentState!.validate()) {
                          registerUser(
                            context,
                            "$_selectedRankCategory:$_selectedRank",
                            nameController.text,
                            navyNoController.text,
                            unitController.text,
                            mobileNoController.text,
                            passwordController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Please fill in all required fields.'),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUpAnimation(
                  duration: const Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RealLoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in',
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
        ),
      ),
    );
  }

  Widget makeDropDownCategory({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          value: _selectedRankCategory,
          items: _rankCategories.keys.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedRankCategory = newValue;
              _selectedRank = null;
            });
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget makeDropDownRanks({required String label}) {
    List<String> ranks = _rankCategories[_selectedRankCategory!] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: _selectedRank,
          items: ranks.map((String rank) {
            return DropdownMenuItem<String>(
              value: rank,
              child: Text(rank),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedRank = newValue;
            });
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<void> registerUser(
    BuildContext context,
    String rank,
    String name,
    String navyNo,
    String unit,
    String mobileNo,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}registerapi.php'),
        body: {
          'rank': rank,
          'name': name,
          'navyNo': navyNo,
          'unit': unit,
          'mobileNo': mobileNo,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Registration"),
                content: const Text("Registration successful!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RealLoginScreen(),
                        ),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Registration"),
                content:
                    Text("Registration failed. ${jsonResponse['message']}"),
                actions: <Widget>[
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
      } else {
        throw Exception('Registration failed.');
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("An error occurred during registration"),
            actions: <Widget>[
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
  }

  Widget makeInput({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    bool phoneNumber = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: phoneNumber ? TextInputType.phone : TextInputType.text,
          inputFormatters:
              phoneNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          validator: validator,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 218, 182, 182)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 233, 199, 199)),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
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
