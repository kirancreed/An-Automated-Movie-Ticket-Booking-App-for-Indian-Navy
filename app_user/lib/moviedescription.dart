import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'seat_booking.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'constant.dart';
import 'package:expandable/expandable.dart';

class MovieDescriptionPage extends StatefulWidget {
  final int mid;

  const MovieDescriptionPage({Key? key, required this.mid}) : super(key: key);

  @override
  _MovieDescriptionPageState createState() => _MovieDescriptionPageState();
}

class _MovieDescriptionPageState extends State<MovieDescriptionPage> {
  String movieName = 'Unknown Movies';
  String movieDescription = "no description";
  late List<Map<String, dynamic>> dateTimes = [];
  String videoId = "0";
  String movieRating = "0";
  String movieImageUrl = "0";
  String starring = "";
  bool isLoading = false;
  String errorMessage = '';

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final url = Uri.parse(
          '${ApiConstants.baseUrl}moviedetails.php?mid=${widget.mid}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movieName = data['NAME'] ?? 'Unknown Movie';
          movieDescription = data['DESCRIPTION'] ?? "no description";
          movieRating = data['RATING'] ?? "0";
          movieImageUrl = data['IMAGE'] ?? '';
          starring = data['STARRING'] ?? "";
          dateTimes = List<Map<String, dynamic>>.from(data['dateTimes'] ?? []);
          final String? youtubeUrl = data['youtubeUrl'];
          const String defaultYoutubeUrl =
              'https://youtu.be/qxOkaU6RVz4?si=Uxz_804KK9ilyR--';

          videoId = youtubeUrl != null
              ? YoutubePlayer.convertUrlToId(youtubeUrl) ?? ''
              : YoutubePlayer.convertUrlToId(defaultYoutubeUrl) ?? '';

          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load movie details: $error';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              movieImageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.7,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black87],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16.0,
                              left: 16.0,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Text(
                                  movieName,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    movieRating,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Icon(Icons.star, color: Colors.amber),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Date and Time',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Changed color to blue
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: dateTimes.map<Widget>((dateTime) {
                                DateTime parsedDate = DateTime.parse(
                                    dateTime['date'] + ' ' + dateTime['time']);
                                String formattedDateTime =
                                    '${parsedDate.day}/${parsedDate.month}/${parsedDate.year} | ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}';
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 128, 189, 238)
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        formattedDateTime,
                                        style: TextStyle(
                                          fontSize: 16, // Decreased font size
                                          color: Colors
                                              .white, // Changed color to blue
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 2),
                          child: ExpandablePanel(
                            header: const Text(
                              'Movie Description',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            collapsed: Text(
                              movieDescription,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                            expanded: Text(
                              movieDescription,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Cast',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Display cast members as a paragraph-like text within styled containers
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Wrap(
                                  spacing:
                                      8.0, // Spacing between each cast member
                                  runSpacing: 8.0, // Spacing between lines
                                  children: [
                                    for (var castMember in starring.split(','))
                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 128, 189, 238)
                                                  .withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 12),
                                        child: Text(
                                          castMember.trim(), // Trim whitespace
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Trailer',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(
                                isExpanded: true,
                                colors: const ProgressBarColors(
                                  playedColor: Colors.amber,
                                  handleColor: Colors.amberAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Adding SizedBox for spacing
                        SizedBox(height: 0),
                      ],
                    ),
                  ),
        bottomNavigationBar: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade200,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 15, 94, 155).withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),

            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 20), // Adjust padding as needed
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatBookingPage(
                      movieName: movieName,
                      dateTimes: dateTimes,
                      movieImageUrl: movieImageUrl,
                      movieId: widget.mid,
                    ),
                  ),
                );
              },
              child: const Text(
                'BOOK YOUR TICKET!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
