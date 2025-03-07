import 'package:flutter/material.dart';
import 'flights_page.dart';
import 'customers_page.dart';
import 'applicators_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const KarribaApp());
}

class KarribaApp extends StatelessWidget {
  const KarribaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karriba',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const KarribaHomePage(),
    );
  }
}

class KarribaHomePage extends StatefulWidget {
  const KarribaHomePage({super.key});

  @override
  State<KarribaHomePage> createState() => _KarribaHomePageState();
}

class _KarribaHomePageState extends State<KarribaHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    FlightsPage(),
    CustomersPage(),
    ApplicatorsPage(),
    SettingsPage(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // AI!: the title should match the currently selected navigation item
        title: const Text("Karriba"),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: 'Flights'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Customers'),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Applicators',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
