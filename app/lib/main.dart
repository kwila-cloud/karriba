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
        useMaterial3: true,
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

  static const List<String> _titleOptions = <String>[
    'Flights',
    'Customers',
    'Applicators',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleOptions.elementAt(_selectedIndex))),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        // AI!: generate this list from _titleOptions
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.flight), label: 'Flights'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Customers'),
          NavigationDestination(
            icon: Icon(Icons.agriculture),
            label: 'Applicators',
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
