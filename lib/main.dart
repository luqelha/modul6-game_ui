import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Daftar Game'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataGame = [];

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  @override
  Future _ambilData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.freetogame.com/api/games'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          dataGame = data.take(20).toList();
        });
      } else {
        throw Exception('Gagal load data dari FreeToGame API');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: dataGame.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              itemCount: dataGame.length,
              itemBuilder: (context, index) {
                return _listItem(
                  dataGame[index]['thumbnail'] ??
                      'https://via.placeholder.com/150',
                  dataGame[index]['title'] ?? 'Tidak ada judul',
                  dataGame[index]['genre'] ?? 'Tidak ada genre',
                  dataGame[index]['release_date'] ?? 'Tidak ada taggal',
                );
              },
            ),
    );
  }
}

Container _tombolBaca() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(15),
    ),
    child: const Text('Baca Info', style: TextStyle(color: Colors.white)),
  );
}

Container _listItem(String url, String judul, String genre, String rilis) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(url, width: 70, height: 70, fit: BoxFit.cover),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          genre,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          rilis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  _tombolBaca(),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
