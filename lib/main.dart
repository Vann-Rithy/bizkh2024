import 'package:flutter/material.dart';
import 'pages/home.dart'; // Ensure these files contain the respective widgets
import 'pages/video.dart';
import 'pages/idea.dart';
import 'pages/calendar.dart';
import 'pages/menu.dart';
import 'pages/splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFFC107),
          secondary: Color(0xFFFFC107),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          displayLarge: TextStyle(
            color: Colors.yellow,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Color(0xFFFFC107), // Custom color for AppBar
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Show splash screen initially
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen();
  }

  void _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Show splash screen for 3 seconds
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Centered logo
            Image.asset('assets/logo.png', width: 150), // Adjust the width as needed
            SizedBox(height: 20),
            // Text at the bottom
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Powered by SME Version 1.0',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    VideoPage(),
    IdeaPage(),
    CalendarPage(),
    MenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your profile image asset
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 45), // Replace with your logo icon
            SizedBox(width: 8),
            Text('ជំនឿ-ជំនួញ', style: TextStyle(fontSize: 20, color: Colors.red)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification icon press
              },
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
           // Set background color here
        child: BottomAppBar(
          color: Color(0xFFFFC107),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavIcon(Icons.home, 0),
              _buildBottomNavIcon(Icons.video_collection, 1),
              _buildBottomNavIcon(Icons.lightbulb, 2),
              _buildBottomNavIcon(Icons.calendar_today, 3),
              _buildBottomNavIcon(Icons.menu, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavIcon(IconData icon, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.red : Colors.black12,
        borderRadius: BorderRadius.circular(12.0),
        
      ),
      padding: EdgeInsets.all(2.0),
      child: IconButton(
        icon: Icon(icon, color: _selectedIndex == index ? Colors.white : Colors.white),
        onPressed: () => _onItemTapped(index),
      ),
    );
  }
}
