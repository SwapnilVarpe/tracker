import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'expenses.dart';
import 'money_stats.dart';
import 'time_schedule.dart';
import 'time_stats.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      }),
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tracker"),
      ),
      body: <Widget>[
        const Expenses(),
        const MoneyStats(),
        const TimeSchedule(),
        const TimeStats()
      ][_currentPageIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentPageIndex = value;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.payments), label: 'Expenses'),
          NavigationDestination(
              icon: Icon(Icons.analytics), label: 'Money Stats'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'Schedule'),
          NavigationDestination(
              icon: Icon(Icons.timeline), label: 'Time Stats'),
        ],
      ),
    );
  }
}
