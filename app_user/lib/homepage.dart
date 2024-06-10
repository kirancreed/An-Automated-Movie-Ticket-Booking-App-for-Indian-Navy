import 'package:flutter/material.dart';
import 'homePage_cards/moviecard.dart';
import 'bottomnavigation.dart';
import 'drawer.dart';
import 'feedback_services.dart';
import 'moviedescription.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'theaterdetails_bottomsheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  int _currentPage = 0;

  List<Movie> movies = [];
  bool showTheaterName = false; // Track the visibility of Sagarika

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response =
        await http.get(Uri.parse('${ApiConstants.baseUrl}imageapi.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        movies = data.map((item) => Movie.fromJson(item)).toList();
      });
    } else {
      print('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
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
                    'Navy Welfare',
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
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackServices(),
              ),
            );
          }
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // New text widget
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return TheaterDetailBottomSheet();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientText(
                  text: 'SAGARIKA ',
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
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GradientText(
                text: 'STREAMING',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                gradient: LinearGradient(colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade300,
                ]),
              ),
            ),
            const SizedBox(height: 5),
            movies.isEmpty
                ? Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10), // Adjust the margin as needed
                      child: Transform.scale(
                        scale: 1.2, // Increase the scale factor as needed
                        child: Image.asset(
                          'assets/no.png', // Replace with your image asset path
                          width: 300, // Adjust width as needed
                          height: 300, // Adjust height as needed
                          // Adjust the fit as needed
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.7, // Increased height for the main cards
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: movies.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double scale = 1.0;
                            if (_pageController.position.haveDimensions) {
                              scale = (_pageController.page! - index)
                                  .abs()
                                  .clamp(0.0, 1.0);
                            }
                            return Transform.scale(
                              scale: 1 -
                                  scale *
                                      0.1, // Adjust the scale factor as needed
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: MovieCard(
                                        imageUrl: movies[index].imageUrl1,
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDescriptionPage(
                                                      mid: movies[index].id),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to another page when the container is clicked
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDescriptionPage(
                                                    mid: movies[index].id),
                                            // Replace AnotherPage with the page you want to navigate to
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          padding: EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.blue.shade800,
                                                Colors.blue.shade200,
                                              ],
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              movies[index].title,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .white, // Set appropriate color
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 1),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        movies.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.blue.shade700
                                : Colors.blueGrey[400],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final int id;
  final String imageUrl1;
  final String title; // Add movie title

  Movie({
    required this.id,
    required this.imageUrl1,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      imageUrl1: json['imageUrl'],
      title: json['name'], // Extract title from JSON
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
