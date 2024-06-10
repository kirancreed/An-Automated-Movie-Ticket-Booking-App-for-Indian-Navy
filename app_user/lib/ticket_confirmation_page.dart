import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'view_ticket.dart';
//import 'package:navy_welfare/seat_booking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart'; // Import the next page to navigate to

class TicketConfirmationPage extends StatefulWidget {
  final DateTime date;
  final TimeOfDay time;
  final List<String> seats;
  final int movieId;
  final String seatType;

  final String movieName;
  final String image;

  const TicketConfirmationPage({
    super.key,
    required this.movieId,
    required this.movieName,
    required this.image,
    required this.date,
    required this.time,
    required this.seats,
    required this.seatType,
  });

  @override
  State<TicketConfirmationPage> createState() => _TicketConfirmationPageState();
}

class _TicketConfirmationPageState extends State<TicketConfirmationPage> {
  late int _uid; // Variable to store uid retrieved from SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadUidFromSharedPreferences();
  }

  // Function to load uid from SharedPreferences
  _loadUidFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid =
          prefs.getInt('U_ID') ?? 0; // Retrieve uid or set it to 0 if not found
    });
    sendDataToAPI(); // Call sendDataToAPI function after getting uid
  }

  // Function to send data to API
  Future<void> sendDataToAPI() async {
    const url = '${ApiConstants.baseUrl}bookingapi.php';

    // Create a JSON object with the data you want to send
    final data = {
      'user_id': _uid.toString(),
      'movie_id': widget.movieId.toString(),
      'date': '${widget.date.year}-${widget.date.month}-${widget.date.day}'
          .toString(),
      'showtime': '${widget.time.hour}:${widget.time.minute}'.toString(),
      'selected_seats': widget.seats.join(','), // Convert list to string
    };

    // print("hiiiiiiiiiiiiiiiiiiii");
    // print('Data sent to API: $data');
    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        // print("sucessssss");
        // print('Response: ${response.body}');
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          // If booking is successful, navigate to next page
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
                builder: (context) => TicketViewPage(
                      // movieId: widget.movieId,
                      date: widget.date,
                      time: widget.time,
                      seats: widget.seats,
                      seatType: widget.seatType,
                      movieName: widget.movieName,
                      image: widget.image,
                    )),
          );
        } else {
          // If booking is not successful, show error message and navigate to another page
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(responseData['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      // Navigate to another page (you can replace `AnotherPage()` with your desired page)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Error sending data
        print('Error sending data: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This page does not display anya content, as the data is sent to API automatically
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Show a loading indicator while sending data
      ),
    );
  }
}
