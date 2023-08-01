import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tracker/add_category.dart';
import 'package:tracker/category_entry_details.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/import.dart';
import 'package:tracker/modal/entry.dart';
import 'package:tracker/util.dart';

import 'expenses.dart';
import 'money_stats.dart';
import 'time_schedule.dart';
import 'time_stats.dart';
import 'new_entry.dart';
import 'db/db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDB();
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: [
        GoRoute(
          path: 'addEntry',
          builder: (BuildContext context, GoRouterState state) {
            return NewEntry(entryId: state.queryParameters['entryId']);
          },
        ),
        GoRoute(
          path: 'add-category',
          builder: (context, state) {
            return const AddCategory();
          },
        ),
        GoRoute(
          path: 'import',
          builder: (context, state) => const Import(),
        ),
        GoRoute(
          path: 'category-entry-details',
          builder: (context, state) {
            return CategoryEntryDetails(
                category: state.queryParameters['category'] ?? '',
                categoryType: CategoryTypeExt.fromString(
                    state.queryParameters['categoryType'] ?? ''),
                endDate: state.queryParameters['endDate'] ?? '',
                startDate: state.queryParameters['startDate'] ?? '');
          },
        )
      ]),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  bool isAuthenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return _splashScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tracker"),
      ),
      drawer: drawer(context),
      body: <Widget>[
        Expenses(),
        const MoneyStats(),
        const TimeSchedule(),
        const TimeStats()
      ][_currentPageIndex],
      floatingActionButton: _currentPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                if (_currentPageIndex == 0) {
                  context.go('/addEntry');
                }
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null,
      // TODO: FAB is hiding last amount.
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Scaffold _splashScreen() => Scaffold(
        backgroundColor: const Color(0xff7959b7),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('lib/assets/icon/only_logo.png'),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        'Money & Time Tracker',
                        style: TextStyle(color: Colors.white54, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: IconButton(
                onPressed: () {
                  _authenticate();
                },
                icon: const Icon(
                  Icons.fingerprint_outlined,
                  color: Colors.white38,
                ),
                style:
                    const ButtonStyle(iconSize: MaterialStatePropertyAll(60)),
              ),
            )
          ],
        ),
      );

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer),
          child: const Text(
            'Tracker app',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          title: const Text('Export'),
          leading: const Icon(Icons.upload),
          onTap: () => _exportData(),
        ),
        ListTile(
          title: const Text('Import'),
          leading: const Icon(Icons.download),
          onTap: () {
            context.pop();
            context.go('/import');
          },
        ),
        // ListTile(
        //   title: const Text('Hide salary'),
        //   leading: const Icon(Icons.money_off),
        //   trailing: Switch(value: true, onChanged: (isSelected) {}),
        // ),
        // ListTile(
        //   title: const Text('Enable biometrics'),
        //   leading: const Icon(Icons.fingerprint),
        //   trailing: Switch(
        //     value: false,
        //     onChanged: (value) {},
        //   ),
        // )
      ]),
    );
  }

  void _exportData() async {
    final dir = await getTemporaryDirectory();
    List<Entry> data = await DBHelper.getAllEntries();
    final str = convertToCSV(data);
    final path = '${dir.path}/mt-data.csv';

    File file = File(path);
    await file.writeAsString(str);
    Share.shareXFiles([XFile(path, mimeType: 'text/csv')],
        subject: 'Exported file');
  }

  void _authenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) {
        _login();
        return;
      }

      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      bool didAuthenticate = false;
      if (availableBiometrics.isNotEmpty) {
        didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(biometricOnly: true));
      } else {
        didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance');
      }

      if (didAuthenticate) {
        _login();
      }
    } on MissingPluginException {
      _login();
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        _login();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void _login() {
    setState(() {
      isAuthenticated = true;
      _currentPageIndex = 0;
    });
  }
}
