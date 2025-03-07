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

  // AI!: remove _widgetOptions and _titleOptions. create new _pageOptions that includes the page title, icon, and page widget
  static final List<Widget> _widgetOptions = <Widget>[
    FlightsPage(),
    CustomersPage(),
    ApplicatorsPage(),
    SettingsPage(),
  ];

  static final List<String> _titleOptions = <String>[
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
        destinations:
            _titleOptions.map((title) {
              IconData icon;
              // AI!: remove this switch, use _pageOptions
              switch (title) {
                case 'Flights':
                  icon = Icons.flight;
                  break;
                case 'Customers':
                  icon = Icons.people;
                  break;
                case 'Applicators':
                  icon = Icons.agriculture;
                  break;
                case 'Settings':
                  icon = Icons.settings;
                  break;
                default:
                  icon = Icons.error; // Fallback icon
              }
              return NavigationDestination(icon: Icon(icon), label: title);
            }).toList(),
      ),
    );
  }
}
