import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/academics/academics.dart';
import 'package:hnu_mis_announcement/drawer/drawer.dart';
import 'package:hnu_mis_announcement/financials/financials.dart';
import 'package:hnu_mis_announcement/homepage/homepage.dart';
import 'package:hnu_mis_announcement/loginPage.dart';


void main() {
  runApp(const MyApp());
}

class Financial {
  final String course;
  final int loadunits;
  final int payunits;
  double get total => payunits * 752.0;

  Financial({
    required this.course,
    required this.loadunits,
    required this.payunits,
  });
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HNU MIS ENROLLMENT',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/second': (context) => const BottomTabs(),
      },
    );
  }
}

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const FinancialsPage(),
    const AcademicsPage(),

  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("HNU MIS ENROLLMENT"),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_outlined),
              label: 'Financials'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
              label: 'Academics'
          ),
        ],
      ),
    );
  }
}





