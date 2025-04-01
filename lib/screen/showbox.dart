import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miniproject/models/get_data_api.dart';
import 'package:miniproject/widget/widget.dart';

class ShowListPokedex extends StatelessWidget {
  late Future<List<dynamic>> data;

  @override
  Widget build(BuildContext context) {
    data = getDataAll();
    return Container(
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          SearchBoxDex(),
          Expanded(
              child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else {
                List<String> listpost = snapshot.data!
                    .map((i) => i['pokemon_species']['name'] as String)
                    .toList();

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.06,
                      ),
                      itemCount: listpost.length,
                      itemBuilder: (context, index) {
                        return CardDex(
                            index,
                            listpost[index],
                            "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/" +
                                (index + 1).toString().padLeft(3, '0') +
                                ".png");
                      }),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

class ShowDetailDex extends StatelessWidget {
  int id;
  late Future<Map<String, dynamic>> data;

  ShowDetailDex(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    data = getDataDetail(id.toInt() + 1);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pokedex"),
        backgroundColor: Colors.amberAccent.shade100,
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LinearProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              "error ${snapshot.error}",
              style: TextStyle(fontSize: 30),
            ));
          } else if (!snapshot.hasData) {
            return Text("Null data ");
          } else {
            Map<String, dynamic> detail = snapshot.data!;
            detail.forEach((key, value) {
              print(key);
            });
            return Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Soft shadow
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "id : ${(id + 1).toString()} " +
                          detail["name"].toString(),
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade300, // Pastel accent
                      ),
                    ),
                  ),
                  Center(
                    child: Image.network(
                      "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/" +
                          (id + 1).toString().padLeft(3, '0') +
                          ".png",
                      height: 250,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Base Happiness: ${detail["base_happiness"].toString()}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.blueGrey.shade600),
                  ),
                  Text(
                    "Capture Rate: ${detail["capture_rate"].toString()}",
                    style: TextStyle(fontSize: 18, color: Colors.teal.shade400),
                  ),
                  Text(
                    "Color: ${detail["color"]["name"].toString()}",
                    style:
                        TextStyle(fontSize: 18, color: Colors.green.shade400),
                  ),
                  Text(
                    "Generation: " + detail["generation"]["name"].toString(),
                    style:
                        TextStyle(fontSize: 18, color: Colors.purple.shade400),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Sound: " +
                        detail["flavor_text_entries"][0]["flavor_text"]
                            .replaceAll('\n', ''),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: 16, color: Colors.blueGrey.shade700),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ShowRandom extends StatefulWidget {
  const ShowRandom({super.key});

  @override
  State<ShowRandom> createState() => _ShowRandomState();
}

class _ShowRandomState extends State<ShowRandom> {
  @override
  Widget build(BuildContext context) {
    Random random = Random();

    int randomPoke = random.nextInt(1025);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDetailDex(randomPoke - 1),
            ));
      },
      child: Container(
        color: Colors.orange.shade100,
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Random Pokemon",
              style: TextStyle(fontSize: 30),
            ),
            Image.network(
              "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/" +
                  (randomPoke).toString().padLeft(3, '0') +
                  ".png",
              height: 450,
              fit: BoxFit.contain,
            ),
            Text(
              "click to see detail",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "id : $randomPoke",
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    randomPoke = random.nextInt(1025) - 1;
                  });
                },
                child: Container(
                  width: 140,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Random",
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(
                        Icons.restart_alt,
                        weight: 40,
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
