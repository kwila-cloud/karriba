import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'applicators_page.dart';
import 'customers_page.dart';
import 'records_page.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFCAA34E)),
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
    PageData(
      title: 'Records',
      icon: Mdi.format_list_bulleted,
      widget: RecordsPage(),
    ),
    PageData(
      title: 'Customers',
      icon: Mdi.account_multiple,
      widget: CustomersPage(),
    ),
    PageData(title: 'Settings', icon: Mdi.cog, widget: SettingsPage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pageOptions[_selectedIndex].title)),
      body: Center(child: _pageOptions[_selectedIndex].widget),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations:
            _pageOptions
                .map(
                  (page) => NavigationDestination(
                    icon: Iconify(page.icon),
                    label: page.title,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class PageData {
  final String title;
  final String icon;
  final Widget widget;

  PageData({required this.title, required this.icon, required this.widget});
}
