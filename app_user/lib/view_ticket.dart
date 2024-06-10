import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'homepage.dart';

class TicketViewPage extends StatelessWidget {
  final String movieName;
  final DateTime date;
  final TimeOfDay time;
  final List<String> seats;
  final String seatType;
  final String image;

  const TicketViewPage({
    Key? key,
    required this.date,
    required this.time,
    required this.seats,
    required this.seatType,
    required this.movieName,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMMMMd().format(date);
    String formattedTime =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.period == DayPeriod.am ? 'AM' : 'PM'}';

    int _compareSeats(String a, String b) {
      // Separate alphabetic and numeric parts
      String aAlpha = a.replaceAll(RegExp(r'[0-9]'), '');
      String bAlpha = b.replaceAll(RegExp(r'[0-9]'), '');
      int aNum = int.parse(a.replaceAll(RegExp(r'[A-Za-z]'), ''));
      int bNum = int.parse(b.replaceAll(RegExp(r'[A-Za-z]'), ''));

      if (aAlpha != bAlpha) {
        // If alphabetic parts are different, compare them
        return aAlpha.compareTo(bAlpha);
      } else {
        // If alphabetic parts are the same, compare numeric parts
        return aNum.compareTo(bNum);
      }
    }

    List<String> balconySeats = seats
        .where((seat) => seat.startsWith('B'))
        .toList()
      ..sort((a, b) => _compareSeats(a, b));
    List<String> groundFloorSeats = seats
        .where((seat) => seat.startsWith('G'))
        .toList()
      ..sort((a, b) => _compareSeats(a, b));

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          ModalRoute.withName('/'),
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.shade900,
                Colors.blue.shade300,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TicketWidget(
                  width: 350,
                  height: 500,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Image.network(
                                  image,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  movieName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 60), // Adjusted spacing
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.shade50,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon((Icons.access_time)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            ' $formattedTime',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue.shade50,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon((Icons.date_range_outlined)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            ' $formattedDate',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(
                                      (Icons.location_on),
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      ' SAGARIKA',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (balconySeats.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      'Balcony - ${balconySeats.map((seat) => seat.substring(1)).join(', ')}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                const SizedBox(height: 5),
                                if (groundFloorSeats.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      'GroundFloor - ${groundFloorSeats.map((seat) => seat.substring(1)).join(', ')}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 1, // Adjust the top position as needed
                        right: 1, // Adjust the right position as needed
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              ModalRoute.withName('/'),
                            );
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 230, // Adjust the top position as needed
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            child: DottedLine(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
