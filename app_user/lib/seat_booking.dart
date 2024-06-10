import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ticket_confirmation_page.dart';
import 'seatcontainer.dart';
//import 'view_ticket.dart';
//import 'booked_ticket.dart';

class SeatBookingPage extends StatefulWidget {
  final String movieName;
  final int movieId;
  final String movieImageUrl;
  final List<Map<String, dynamic>> dateTimes;
  const SeatBookingPage({
    super.key,
    required this.movieName,
    required this.movieImageUrl,
    required this.dateTimes,
    required this.movieId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SeatBookingPageState createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends State<SeatBookingPage> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  List<String> selectedSeats = [];
  bool isTimeVisible = false;

  Map<DateTime, List<TimeOfDay>> availableTimes = {};

  late List<DateTime> predefinedDates;
  List<TimeOfDay>? selectedTimes;

  @override
  void initState() {
    super.initState();

    // Extract unique dates from the provided date-time mappings
    Set<DateTime> uniqueDates = {};
    for (var dateTimeMap in widget.dateTimes) {
      String dateString = dateTimeMap['date']!;
      DateTime date = DateTime.parse(dateString);
      uniqueDates.add(date);
    }

    // Convert the set of unique dates to a sorted list
    predefinedDates = uniqueDates.toList()..sort();

    // Initialize availableTimes map with empty lists for each unique date
    availableTimes = Map.fromIterable(predefinedDates, value: (_) => []);

    // Populate availableTimes with the associated times for each unique date
    for (var dateTimeMap in widget.dateTimes) {
      String dateString = dateTimeMap['date']!;
      DateTime date = DateTime.parse(dateString);

      String timeString = dateTimeMap['time']!;
      List<String> timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      availableTimes[date]!.add(TimeOfDay(hour: hour, minute: minute));
    }

    // Sort the times for each date
    availableTimes.forEach((date, times) {
      times.sort((a, b) => a.hour != b.hour
          ? a.hour.compareTo(b.hour)
          : a.minute.compareTo(b.minute));
    });

    // Set initial selected date and time
    selectedDate =
        predefinedDates.isNotEmpty ? predefinedDates.first : DateTime.now();
    selectedTime = availableTimes[selectedDate]?.isNotEmpty == true
        ? availableTimes[selectedDate]!.first
        : TimeOfDay.now();

    selectedTimes = availableTimes[selectedDate];
    isTimeVisible = true;
  }

  String getSeatType(List<String> selectedSeats) {
    bool hasBalcony = false;
    bool hasGroundFloor = false;

    for (String seat in selectedSeats) {
      if (seat.startsWith('B')) {
        hasBalcony = true;
      } else if (seat.startsWith('G')) {
        hasGroundFloor = true;
      }
    }

    if (hasBalcony && hasGroundFloor) {
      return 'Balcony(B), Ground Floor(G)';
    } else if (hasBalcony) {
      return 'Balcony(B)';
    } else if (hasGroundFloor) {
      return 'Ground Floor(G)';
    } else {
      return '';
    }
  }

  // Function to reset selected seats
  void resetSeats() {
    setState(() {
      selectedSeats.clear(); // Clear the selectedSeats list
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAnySeatSelected = selectedSeats.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade300
              ], // Your gradient colors
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Center(
          child: Text(
            widget.movieName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add your refresh logic here
              resetSeats();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            "Select Date and Time!",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: predefinedDates
                                .map((date) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = date;
                                          isTimeVisible = true;
                                          selectedTimes =
                                              availableTimes[selectedDate];
                                          // Set the selected time to the first available time for the selected date
                                          selectedTime =
                                              selectedTimes != null &&
                                                      selectedTimes!.isNotEmpty
                                                  ? selectedTimes![0]
                                                  : TimeOfDay.now();
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: selectedDate == date
                                              ? Colors.green
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(date),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: selectedDate == date
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (isTimeVisible &&
                              selectedTimes != null &&
                              selectedTimes!.isNotEmpty)
                            Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: selectedTimes!.map((time) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTime = time;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.green),
                                          color: selectedTime == time
                                              ? Colors.green
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Text(
                                          '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: selectedTime == time
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isTimeVisible ||
                    selectedTimes == null ||
                    selectedTimes!
                        .isEmpty) // Only show space for time selection if a date is selected
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Select Your Seats..",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Stack(children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SeatingArrangement(
                              selectedSeats: selectedSeats,
                              // bookedSeats: bookedSeats,
                              onSeatTapped: (seat) {
                                setState(() {
                                  if (selectedSeats.contains(seat)) {
                                    selectedSeats.remove(seat);
                                  } else {
                                    selectedSeats.add(seat);
                                  }
                                });
                              },
                              onResetSeats: resetSeats,
                              selectedDate:
                                  selectedDate, // Pass the selected date
                              selectedTime: selectedTime,
                              movieId: widget.movieId, // Pass the selected time
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                // Generate rows
                                //A-E for the balcony
                                ...List.generate(5, (index) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 29,
                                    child: Text(
                                      '${String.fromCharCode(index + 65)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  height: 65,
                                ),
                                // Generate rows A-M for the ground floor
                                ...List.generate(8, (index) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 28,
                                    child: Text(
                                      '${String.fromCharCode(index + 65)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                }),
                                const SizedBox(height: 20),
                                ...List.generate(5, (index) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 29,
                                    child: Text(
                                      '${String.fromCharCode(index + 73)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20),
                        CustomPaint(
                          size: Size(MediaQuery.of(context).size.width, 30),
                          painter: ScreenPainter(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: const Text(
                            "SCREEN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isAnySeatSelected)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            margin: const EdgeInsets.all(3),
                            color: Colors.green,
                          ),
                          const Text("Selected")
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            margin: const EdgeInsets.all(3),
                            color: Colors.black,
                          ),
                          const Text("Sold")
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    Colors.green, // Change the color as desired
                                // Adjust the border width
                              ),
                            ),
                          ),
                          const Text("Available")
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: ScaleTransition(
                              scale: CurvedAnimation(
                                parent: ModalRoute.of(context)!.animation!,
                                curve: Curves.easeInOutBack,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: const Text(
                                      'Confirm Booking',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    const SizedBox(height: 10),
                                    Text('Movie: ${widget.movieName}'),
                                    Text(
                                      'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                    ),
                                    Text(
                                      'Time: ${selectedTime.hour}:${selectedTime.minute}',
                                    ),
                                    Text('Seats: ${selectedSeats.join(', ')}'),
                                    Text(
                                      'Seat Type: ${getSeatType(selectedSeats)}',
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade800,
                                                Colors.blue.shade400,
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 38,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade800,
                                                Colors.blue.shade400,
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Navigate to TicketConfirmationPage
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TicketConfirmationPage(
                                                    movieId: widget.movieId,
                                                    movieName: widget.movieName,
                                                    date: selectedDate,
                                                    time: selectedTime,
                                                    seats: selectedSeats,
                                                    seatType: getSeatType(
                                                        selectedSeats),
                                                    image: widget.movieImageUrl,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              elevation:
                                                  MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Book'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width / 2, 20, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BookedTicket {
  static int _containerCount = 0;

  static void incrementContainer() {
    _containerCount++;
  }

  static int getContainerCount() {
    return _containerCount;
  }
}
