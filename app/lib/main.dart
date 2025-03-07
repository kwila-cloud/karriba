import 'package:flutter/material.dart';
import 'flights_page.dart';
import 'customers_page.dart';
import 'applicators_page.dart';
import 'settings_page.dart';

void main() {
  runApp(const KarribaApp());
}

class PageData {
  final String title;
  final IconData icon;
  final Widget widget;

  PageData({required this.title, required this.icon, required this.widget});
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

  static final List<PageData> _pageOptions = [
    PageData(title: 'Flights', icon: Icons.flight, widget: FlightsPage()),
    PageData(title: 'Customers', icon: Icons.people, widget: CustomersPage()),
    PageData(
        title: 'Applicators', icon: Icons.agriculture, widget: ApplicatorsPage()),
    PageData(title: 'Settings', icon: Icons.settings, widget: SettingsPage()),
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
        title: Text(_pageOptions[_selectedIndex].title),
      ),
      body: Center(child: _pageOptions[_selectedIndex].widget),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: _pageOptions
            .map(
              (page) => NavigationDestination(
                icon: Icon(page.icon),
                label: page.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
