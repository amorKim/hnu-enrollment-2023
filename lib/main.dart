import 'package:flutter/material.dart';
import 'package:hnu_mis_announcement/views/academics/academics.dart';
import 'package:hnu_mis_announcement/drawer/drawer.dart';
import 'package:hnu_mis_announcement/views/financials/financials.dart';
import 'package:hnu_mis_announcement/views/homepage/homepage.dart';
import 'package:hnu_mis_announcement/views/login_page.dart';
import 'package:hnu_mis_announcement/services/auth/auth_service.dart';
import 'package:hnu_mis_announcement/views/constants/route.dart';
import 'package:hnu_mis_announcement/views/register_view.dart';
import 'package:hnu_mis_announcement/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HNU MIS ENROLLMENT',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LandingPage(),
      routes: {
        loginRoute: (context) => const LoginPage(),
        dashboardRoute: (context) => const DashboardPage(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const DashboardPage();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginPage();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const FinancialsPage(),
    const AcademicsPage(),
  ];

  void onTappedBar(int index) {
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_outlined), label: 'Financials'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Academics'),
        ],
      ),
    );
  }
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
