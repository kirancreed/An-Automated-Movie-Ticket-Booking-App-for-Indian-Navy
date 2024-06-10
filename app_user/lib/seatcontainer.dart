import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constant.dart';

class SeatingArrangement extends StatefulWidget {
  final List<String> selectedSeats;
  // final List<String> bookedSeats = ["GA25"]; // List of already booked seats
  final void Function(String) onSeatTapped;
  // final datenew = date;
  final void Function() onResetSeats; // Function to reset selected seats
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final int movieId;

  const SeatingArrangement({
    super.key,
    required this.selectedSeats,
    // required this.bookedSeats,
    required this.onSeatTapped,
    required this.onResetSeats,
    required this.selectedDate,
    required this.selectedTime,
    required this.movieId,
  });

  @override
  State<SeatingArrangement> createState() => _SeatingArrangementState();
}

class _SeatingArrangementState extends State<SeatingArrangement> {
  late List<String> bookedSeats = [];

  @override
  void initState() {
    super.initState();
    fetchBookedSeats();
  }

  @override
  void didUpdateWidget(covariant SeatingArrangement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate ||
        widget.selectedTime != oldWidget.selectedTime) {
      fetchBookedSeats();
    }
  }

  Future<void> fetchBookedSeats() async {
    String formattedDate =
        "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";

    // Format selectedTime
    String formattedTime =
        "${widget.selectedTime.hour.toString().padLeft(2, '0')}:${widget.selectedTime.minute.toString().padLeft(2, '0')}:00";
    // Replace with your PHP API URL
    try {
      final seats = await _fetchSeatsFromAPI(formattedDate, formattedTime);
      setState(() {
        bookedSeats = seats;
      });
    } catch (error) {
      print("Error fetching booked seats: ");
      // Handle error
    }
    print('Movie ID:');
    print(formattedTime);
    print('Selected Date: ${widget.selectedDate}');
    // print('Selected Time: ${widget.selectedTime}');
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: {
    //     'mid': widget.movieId.toString(),
    //     'date': formattedDate, // Pass formatted date
    //     'time': formattedTime, // Pass formatted time
    //   },
    // );
    // if (response.statusCode == 200) {
    //   // print(response);
    //   print(response);
    //   final List<dynamic> data = jsonDecode(response.body);
    //   print(data);
    //   return data.map((seat) => seat.toString()).toList();
    // } else {
    //   throw Exception('Failed to load booked seats');
    // }
  }

  Future<List<String>> _fetchSeatsFromAPI(
      String formattedDate, String formattedTime) async {
    const url =
        '${ApiConstants.baseUrl}/bookedseat.php'; // Replace with your PHP API URL
    final response = await http.post(
      Uri.parse(url),
      body: {
        'mid': widget.movieId.toString(),
        'date': formattedDate,
        'time': formattedTime,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((seat) => seat.toString()).toList();
    } else {
      throw Exception('Failed to load booked seats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Balcony',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
          ),
          _buildBalconySeats(),
          const SizedBox(
            width: 10,
            height: 30,
          ),
          Row(
            children: [
              const Text(
                'Ground Floor',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
              const SizedBox(width: 470), // Adding space between the texts
              const Text(
                '<<---------(Families)--------->>',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              ),
            ],
          ),
          _buildGroundFloorSeats(),
        ],
      ),
    );
  }

  Widget _buildBalconySeats() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildBalconyRow(24,
              row: 1, rowIdPrefix: 'B', gapCol1: 6, gapCol2: 18),
          for (int row = 0; row < 4; row++)
            _buildBalconyRow(24,
                row: row + 2, rowIdPrefix: 'B', gapCol1: 6, gapCol2: 18),
        ],
      ),
    );
  }

  Widget _buildBalconyRow(int seatCount,
      {int? row, String? rowIdPrefix, int gapCol1 = 1, int gapCol2 = 0}) {
    List<Widget> children = [];

    children.add(const SizedBox(width: 1 * 20)); // Start gap
    String rowId = String.fromCharCode(64 + row!);

    for (int col = seatCount; col >= 1; col--) {
      if (col == 6 || col == 18) {
        children.add(const SizedBox(width: 2 * 20)); // Add space before seat 6
      }
      children.add(GestureDetector(
        onTap: () => widget.onSeatTapped('$rowIdPrefix$rowId$col'),
        child: _buildSeatWidget('$rowIdPrefix$rowId$col'),
      ));
    }

    children.add(SizedBox(width: gapCol2 * 2)); // End gap

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildGroundFloorSeats() {
    print(bookedSeats);
    // print("selectedDate");
    // print(widget.selectedDate);
    // print(widget.selectedTime);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildGroundFloorRow(26, row: 1, rowIdPrefix: 'G'),
          for (int i = 0; i < 5; i++)
            _buildGroundFloorRow(24, row: i + 2, rowIdPrefix: 'G'),
          _buildGroundFloorRow(22,
              row: 7, rowIdPrefix: 'G', startSpace: 1, endSpace: 1),
          _buildGroundFloorRow(22,
              row: 8, rowIdPrefix: 'G', startSpace: 1, endSpace: 1),
          const SizedBox(height: 1 * 20), // 2-row gap
          for (int i = 0; i < 5; i++)
            _buildGroundFloorRow(22, row: i + 9, rowIdPrefix: 'G'),
        ],
      ),
    );
  }

  Widget _buildGroundFloorRow(int seatCount,
      {int? row, String? rowIdPrefix, int startSpace = 1, int endSpace = 1}) {
    List<Widget> children = [];

    String rowId = String.fromCharCode(64 + row!);

    children.add(SizedBox(width: startSpace * 20)); // Start space

    for (int col = seatCount; col >= 1; col--) {
      if (seatCount == 26 && col == 13) {
        children.add(const SizedBox(
            width: 2 * 20)); // Add space after seat 12 in the first row
      } else if (seatCount == 24 && col == 12) {
        children.add(const SizedBox(width: 2 * 20));
      } // Add space after seat 11 in the next 6 rows
      else if (seatCount == 22 && col == 11) {
        children.add(const SizedBox(
            width: 2 * 20)); // Add space after seat 11 in the next 6 rows
      }
      children.add(
        GestureDetector(
          onTap: () => widget.onSeatTapped('$rowIdPrefix$rowId$col'),
          child: _buildSeatWidget('$rowIdPrefix$rowId$col'), // Pass seat number
        ),
      );
    }

    children.add(SizedBox(width: endSpace * 2)); // End space

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildSeatWidget(String seatId) {
    // Extracting the numeric seat number from the seatId
    int seatNumber = int.parse(seatId.substring(2));

    bool isBooked = bookedSeats.contains(seatId);

    return GestureDetector(
      onTap: () {
        // Check if the seat is not booked before calling onSeatTapped
        if (!isBooked) {
          widget.onSeatTapped(seatId);
        }
      },
      child: Container(
        width: 22,
        height: 22,
        margin: const EdgeInsets.all(3),
        decoration: _getSeatDecoration(seatId),
        child: Center(
          child: Text(
            '$seatNumber',
            style: const TextStyle(fontSize: 8),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getSeatDecoration(String seatId) {
    bool isSelected = widget.selectedSeats.contains(seatId);
    bool isBooked = bookedSeats.contains(seatId);

    if (isBooked) {
      return BoxDecoration(
        border: Border.all(
            color: Colors.grey), // Change border color for booked seats
        color: Colors.grey, // Change background color for booked seats
      );
    } else {
      return isSelected
          ? BoxDecoration(
              border: Border.all(color: Colors.green),
              color: Colors.green,
            )
          : BoxDecoration(
              border: Border.all(color: Colors.green),
              color: Colors.white,
            );
    }
  }
}
