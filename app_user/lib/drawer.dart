import 'package:flutter/material.dart';
import 'Login.dart';
import 'booked_ticket.dart';
// import 'package:navy_welfare/seat_booking.dart';
// import 'package:navy_welfare/view_ticket.dart';
// import 'package:navy_welfare/view_ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'help.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: FutureBuilder(
          future: _loadUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 250,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade800,
                            Colors.blue.shade400,
                          ],
                        ),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: double.infinity),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                  width: 60,
                                  height: 60,
                                  image: AssetImage('assets/avatar.png'),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      // const SizedBox(height: 5),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          snapshot.data?['name'] ?? 'NAME',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            snapshot.data?['rank'] ?? 'RANK',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_movies_rounded),
                    title: const Text('View Ticket'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BookedTicketsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('Logout'),
                    onTap: () {
                      signout(context);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, String>> _loadUserData() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    String name = _sharedPrefs.getString('NAME') ?? 'NAME';
    String rank = _sharedPrefs.getString('RANK') ?? 'RANK';
    //print(name);

    return {'name': name, 'rank': rank};
  }

  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();

    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _sharedPrefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx1) => const RealLoginScreen()),
                  (route) => false,
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}

Future<Map<String, String>> _loadUserData() async {
  final _sharedPrefs = await SharedPreferences.getInstance();
  String name = _sharedPrefs.getString('NAME') ?? 'NAME';
  String rank = _sharedPrefs.getString('RANK') ?? 'RANK';
  //print(name);

  return {'name': name, 'rank': rank};
}

signout(BuildContext ctx) async {
  final _sharedPrefs = await SharedPreferences.getInstance();

  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await _sharedPrefs.clear();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx1) => const RealLoginScreen()),
                (route) => false,
              );
            },
            child: Text("Logout"),
          ),
        ],
      );
    },
  );
}
