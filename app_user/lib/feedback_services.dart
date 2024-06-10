import 'package:flutter/material.dart';
import 'homepage.dart';
import 'feedback_page.dart';
import 'drawer.dart';
import 'bottomnavigation.dart';

class FeedbackServices extends StatefulWidget {
  FeedbackServices({Key? key}) : super(key: key);

  @override
  _FeedbackServicesState createState() => _FeedbackServicesState();
}

class _FeedbackServicesState extends State<FeedbackServices> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<Map<String, dynamic>> _services = [
    {
      'text': 'Canteen',
      'icon': Icons.local_dining,
      'color': Colors.green,
      'route': const FeedbackPage(title: 'Canteen Feedback'),
    },
    {
      'text': 'Barber',
      'icon': Icons.add_to_queue,
      'color': Colors.blue,
      'route': const FeedbackPage(title: 'Barber Feedback'),
    },
    {
      'text': 'Shop',
      'icon': Icons.shopping_bag,
      'color': Colors.orange,
      'route': const FeedbackPage(title: 'Shop Feedback'),
    },
    {
      'text': 'Stay',
      'icon': Icons.hotel,
      'color': Colors.purple,
      'route': const FeedbackPage(title: 'Stay Feedback'),
    },
  ];

  late List<Map<String, dynamic>> _filteredServices;

  @override
  void initState() {
    super.initState();
    _filteredServices = List.from(_services);
    _searchController.addListener(_filterServices);
  }

  void _filterServices() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _isSearching = query.isNotEmpty;
      _filteredServices = _services.where((service) {
        return service['text'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    'Feedback Services',
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (index == 1) {
            // Already on feedback services page
          }
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                    _isSearching ? Colors.blue.shade300 : Colors.blue.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade100,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 24, color: Colors.white),
                  hintText: 'Search services...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon:
                              Icon(Icons.clear, size: 24, color: Colors.white),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please select your service.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _filteredServices.isEmpty
                ? Center(
                    child: Text(
                      'No services found.',
                      style: TextStyle(
                          fontSize: 18.0, fontStyle: FontStyle.italic),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredServices.length,
                    itemBuilder: (context, index) {
                      final service = _filteredServices[index];
                      return FeedbackServiceItem(
                        text: service['text'],
                        icon: service['icon'],
                        color: service['color'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => service['route']),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FeedbackServiceItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeedbackServiceItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
