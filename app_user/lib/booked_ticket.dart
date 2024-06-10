import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_ticket.dart';

class BookedTicketsPage extends StatefulWidget {
  const BookedTicketsPage({Key? key});

  @override
  _BookedTicketsPageState createState() => _BookedTicketsPageState();
}

class _BookedTicketsPageState extends State<BookedTicketsPage> {
  List<TicketInfo> bookedTickets = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookedTickets();
  }

  Future<void> fetchBookedTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('U_ID');

    if (userId != null) {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}ticket.php?userId=$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        List<TicketInfo> tickets = [];

        userData.forEach((userId, userTickets) {
          (userTickets as Map<String, dynamic>)
              .forEach((scheduleId, ticketData) {
            tickets.add(TicketInfo.fromJson(ticketData));
          });
        });

        // Sorting booked tickets by booking date in reverse order
        tickets.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));

        setState(() {
          bookedTickets = tickets;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('User ID not found in SharedPreferences');
    }
  }

  void cancelTicket(TicketInfo ticket) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('U_ID');

      if (userId != null) {
        // Calculate the show time by combining the date and time from the ticket
        DateTime showDateTime = DateTime(
          ticket.date.year,
          ticket.date.month,
          ticket.date.day,
          ticket.time.hour,
          ticket.time.minute,
        );

        // Calculate the current time
        DateTime currentTime = DateTime.now();

        // Calculate the time difference between the show time and the current time
        Duration timeDifference = showDateTime.difference(currentTime);

        // Check if the cancellation time limit is exceeded
        if (timeDifference.inMinutes <= 15) {
          // Show a message indicating that the ticket cannot be cancelled
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'This ticket cannot be cancelled as the show time is within 15 minutes.'),
            ),
          );
        } else {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Confirm Cancellation'),
                content:
                    const Text('Are you sure you want to cancel this ticket?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      performTicketCancellation(ticket);
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        throw Exception('User ID not found ');
      }
    } catch (error) {
      // Handle any errors that occur during cancellation
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to cancel ticket. Please try again later.'),
        ),
      );
    }
  }

  void performTicketCancellation(TicketInfo ticket) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}cancelTicket.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'bookingId': ticket.bookingId,
        }),
      );

      print(
          'Cancellation request response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        // Ticket cancellation successful, update UI
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ticket cancelled successfully'),
          ),
        );

        // Refresh the page by pushing a new instance of BookedTicketsPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BookedTicketsPage(),
          ),
        );
      } else {
        // Ticket cancellation failed, show error message
        throw Exception('Failed to cancel ticket');
      }
    } catch (error) {
      // Handle any errors that occur during cancellation
      print('Error cancelling ticket: $error');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to cancel ticket. Please try again later.'),
        ),
      );
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
                    'Booked Tickets',
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
      body: bookedTickets.isEmpty
          ? const Center(
              child: Text('No tickets booked'),
            )
          : ListView.builder(
              itemCount: bookedTickets.length,
              itemBuilder: (context, index) {
                TicketInfo ticket = bookedTickets[index];
                return TicketContainer(
                  ticket: ticket,
                  onCancel: () => cancelTicket(ticket),
                );
              },
            ),
    );
  }
}

class TicketContainer extends StatelessWidget {
  final TicketInfo ticket;
  final VoidCallback onCancel;

  const TicketContainer({
    Key? key,
    required this.ticket,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 7, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.network(
                        ticket.image,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.movieName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DateFormat('EEE, d MMMM').format(ticket.date),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${ticket.time.hourOfPeriod}:${ticket.time.minute.toString().padLeft(2, '0')} ${ticket.time.period == DayPeriod.am ? 'AM' : 'PM'}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Seats: ${ticket.seats.join(', ')}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Type: ${ticket.seatType}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      // Text(
                      //   'Booking Date: ${DateFormat('EEE, d MMMM').format(ticket.bookingDate)}',
                      //   style: const TextStyle(fontSize: 16),
                      // ),
                      const SizedBox(height: 10),
                      if (ticket.movieStatus == 0 &&
                          (ticket.scheduleStatus == 0 ||
                              ticket.scheduleStatus == 2))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TicketViewPage(
                                      // movieId: 1,
                                      movieName: ticket.movieName,
                                      date: ticket.date,
                                      time: ticket.time,
                                      seats: ticket.seats,
                                      seatType: ticket.seatType,
                                      image: ticket.image,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Set background color to blue
                              ),
                              child: const Text(
                                'View',
                                style: TextStyle(
                                  color:
                                      Colors.white, // Set text color to black
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: onCancel,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.red, // Set background color to red
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color:
                                      Colors.white, // Set text color to black
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        const Text(
                          'Show cancelled',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TicketInfo {
  final String movieName;
  final DateTime date;
  final TimeOfDay time;
  final List<String> seats;
  final String seatType;
  final String image;
  final DateTime bookingDate;
  final String bookingId;
  final int scheduleStatus;
  final int movieStatus;

  TicketInfo({
    required this.movieStatus,
    required this.scheduleStatus,
    required this.bookingId,
    required this.movieName,
    required this.date,
    required this.time,
    required this.seats,
    required this.seatType,
    required this.image,
    required this.bookingDate,
  });

  factory TicketInfo.fromJson(Map<String, dynamic> json) {
    String movieName = json['movieName'] ?? '';
    String bookingId = json['bookingId'] ?? '';
    int movieStatus = json['movieStatus'] ?? '';
    int scheduleStatus = json['scheduleStatus'] ?? '';

    DateTime date =
        json['date'] != null ? DateTime.parse(json['date']) : DateTime.now();
    TimeOfDay time = json['time'] != null
        ? TimeOfDay(
            hour: int.parse(json['time'].split(':')[0]),
            minute: int.parse(json['time'].split(':')[1]),
          )
        : TimeOfDay.now();
    List<String> seats =
        json['seats'] != null ? List<String>.from(json['seats']) : [];
    String seatType = json['seatType'] ?? '';
    String image = json['image'] ?? '';
    DateTime bookingDate =
        json['bookingDate'] != null && json['bookingDate'] != 'null'
            ? DateTime.parse(json['bookingDate'])
            : DateTime.now();

    // If seat type is not provided, derive it from the seat numbers
    if (seatType.isEmpty) {
      bool hasBalcony = false;
      bool hasGroundFloor = false;

      for (String seat in seats) {
        if (seat.startsWith('B')) {
          hasBalcony = true;
        } else if (seat.startsWith('G')) {
          hasGroundFloor = true;
        }
      }

      if (hasBalcony && hasGroundFloor) {
        seatType = 'Balcony(B), Ground Floor(G)';
      } else if (hasBalcony) {
        seatType = 'Balcony(B)';
      } else if (hasGroundFloor) {
        seatType = 'Ground Floor(G)';
      } else {
        seatType = 'Ground'; // Default type if no specific type found
      }
    }

    return TicketInfo(
      movieName: movieName,
      date: date,
      time: time,
      seats: seats,
      seatType: seatType,
      image: image,
      bookingDate: bookingDate,
      bookingId: bookingId,
      scheduleStatus: scheduleStatus,
      movieStatus: movieStatus,
    );
  }
}
