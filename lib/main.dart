import 'package:flutter/material.dart';
import 'package:miniproject/screen/showbox.dart';

main() {
  runApp(MaterialApp(
    home: const MyApp(),
    theme: ThemeData(fontFamily: 'cyberDisplay'),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<dynamic>> data;
  final List<Widget> pages = [ShowListPokedex(), const ShowRandom()];
  int indexScreen = 0;

//entry_number
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Pokedex")),
        backgroundColor: Colors.orange.shade200,
      ),
      body: pages[indexScreen],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexScreen,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 15,
          unselectedFontSize: 10,
          backgroundColor: Colors.orange.shade200,
          onTap: (index) {
            setState(() {
              indexScreen = index;
            });
          },
          unselectedIconTheme: const IconThemeData(size: 20),
          selectedIconTheme: const IconThemeData(size: 30),
          iconSize: 20,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.book), label: "Pokedex"),
            BottomNavigationBarItem(
                icon: Icon(Icons.restart_alt), label: "Ranom")
          ]),
    );
  }
}
