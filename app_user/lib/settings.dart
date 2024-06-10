import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constant.dart'; // Importing the constant file
import 'package:shared_preferences/shared_preferences.dart'; // Importing shared_preferences package
import 'drawer.dart'; // Importing drawer.dart to access the signout function

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _userId = '';
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  String _deleteAccountMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  // Function to load user ID from shared preferences
  void _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('U_ID').toString(); // Convert to string
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Settings Demo',
      theme: ThemeData.light(), // Light theme as default
      home: Scaffold(
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
                      'Settings',
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
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              buildSectionTitle('Account'),
              buildAccountTile(context),
              const SizedBox(height: 20.0),
              buildSectionTitle('Password'),
              buildOptionText(
                text: '   Change Your Password',
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black, // Set text color to black
                ),
                onTap: () {
                  _openPasswordChangeDialog(context);
                },
              ),
              const SizedBox(height: 20.0),
              if (_deleteAccountMessage.isNotEmpty)
                Text(
                  _deleteAccountMessage,
                  style: TextStyle(
                    color: _deleteAccountMessage.startsWith('Account deleted')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GradientText(
        text: title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Keep the original color for section titles
        ),
        gradient: LinearGradient(colors: [
          Colors.blue.shade900,
          Colors.blue.shade400,
        ]),
      ),
    );
  }

  Widget buildAccountTile(BuildContext context) {
    return ListTile(
      title: const Text(
        'Deactivate Account',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black, // Keep the original color for account tile title
        ),
      ),
      onTap: () {
        _showDeactivationConfirmationDialog(context);
      },
    );
  }

  void _showDeactivationConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text(
              textAlign: TextAlign.start,
              "Are you sure you want to permanently delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                _deleteAccount(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(BuildContext context) async {
    Uri url = Uri.parse('${ApiConstants.baseUrl}removeapi.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getInt('U_ID').toString();

    // Prepare the request body with userId
    Map<String, String> requestBody = {
      'userId': userId,
    };

    try {
      var response = await http.post(url, body: requestBody);

      if (response.statusCode == 200) {
        // Account deletion successful
        setState(() {
          _deleteAccountMessage = 'Account deleted successfully';
        });

        // Show popup message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Account Deleted"),
              content: Text("Your account has been deleted successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Call signout function in drawer.dart
                    MyDrawer().signout(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Account deletion failed
        setState(() {
          _deleteAccountMessage = 'Failed to delete account';
        });
      }
    } catch (error) {
      // Error occurred
      setState(() {
        _deleteAccountMessage = 'An error occurred: $error';
      });
    }
  }

  Widget buildOptionText({
    required String text,
    required VoidCallback onTap,
    required TextStyle style,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  void _openPasswordChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      const Text(
                        " Change Password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _PasswordChangeForm(
                        onOldPasswordChanged: (value) {
                          setState(() {
                            _oldPassword = value; // Update old password
                          });
                        },
                        onNewPasswordChanged: (value) {
                          setState(() {
                            _newPassword = value; // Update new password
                          });
                        },
                        onConfirmPasswordChanged: (value) {
                          setState(() {
                            _confirmPassword = value; // Update confirm password
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade800,
                                  Colors.blue.shade300,
                                ],
                              ),
                            ),
                            child: ElevatedButton(
                              child: const Text(
                                "Change Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              onPressed: () {
                                _changePassword();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _changePassword() async {
    if (_newPassword != _confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Password Error"),
            content:
                const Text("New password and confirm password must match."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Construct the complete URL using the base URL from the constant file
    Uri url = Uri.parse('${ApiConstants.baseUrl}/userapi.php');
    // Prepare the request body
    Map<String, String> requestBody = {
      'userId': _userId,
      'old_password': _oldPassword,
      'new_password': _newPassword,
    };

    // Call the API
    try {
      var response = await http.post(url, body: requestBody);

      // Check the response status code
      if (response.statusCode == 200) {
        // Parse the response content
        var responseData = jsonDecode(response.body);

        // Check if the password change was successful
        if (responseData['success'] == true) {
          // Password change successful
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Password Changed"),
                content:
                    const Text("Your password has been changed successfully."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Password change failed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Failed to Change Password"),
                content:
                    const Text("Failed to change password. Please try again."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Unsuccessful response
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Failed to Change Password"),
              content:
                  const Text("Failed to change password. Please try again."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Error occurred
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("An error occurred: $error"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class _PasswordChangeForm extends StatefulWidget {
  final ValueChanged<String> onOldPasswordChanged;
  final ValueChanged<String> onNewPasswordChanged;
  final ValueChanged<String> onConfirmPasswordChanged;

  const _PasswordChangeForm({
    required this.onOldPasswordChanged,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
  });

  @override
  __PasswordChangeFormState createState() => __PasswordChangeFormState();
}

class __PasswordChangeFormState extends State<_PasswordChangeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Old Password'),
            obscureText: true,
            onChanged: (value) {
              widget.onOldPasswordChanged(value); // Update old password
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your old password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(labelText: 'New Password'),
            obscureText: true,
            onChanged: (value) {
              widget.onNewPasswordChanged(value); // Update new password
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your new password';
              }
              return null;
            },
          ),
          const SizedBox(height: 2),
          TextFormField(
            decoration:
                const InputDecoration(labelText: 'Confirm New Password'),
            obscureText: true,
            onChanged: (value) {
              widget.onConfirmPasswordChanged(value); // Update confirm password
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your new password';
              } else if (value != widget.onNewPasswordChanged) {
                // Change _newPassword to widget.onNewPasswordChanged
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
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
