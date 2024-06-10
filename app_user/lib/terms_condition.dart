import 'package:flutter/material.dart';
import 'login.dart';
import 'loginscreen.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(40.0), // Change the height as needed
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
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
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  'By using this app, you agree to the following terms and conditions:',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '1. This app is intended only for military personnel. Any unauthorized access or use by individuals not associated with the military may result in legal action and punishment.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '2. Users of this app are responsible for maintaining the confidentiality of their account and password.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '3. The app developers reserve the right to suspend or terminate accounts that violate these terms and conditions.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '4. The app developers are not liable for any damages or losses incurred through the use of this app.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '5. By using this app, you agree to abide by all laws and regulations governing its use.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  textAlign: TextAlign.justify,
                  '6. These terms and conditions may be subject to change without prior notice. It is the user\'s responsibility to regularly check for updates.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      'I accept the terms & conditions',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isChecked
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RealLoginScreen(),
                            ),
                          ); // Continue button action
                        }
                      : null,
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
