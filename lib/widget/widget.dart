import 'package:flutter/material.dart';
import 'package:miniproject/screen/showbox.dart';

class CardDex extends StatelessWidget {
  String name;
  String imgpath;
  int id;

  CardDex(this.id, this.name, this.imgpath, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowDetailDex(id),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 3, offset: Offset(2, 5))
              ]),

          // height: 200,
          // width: MediaQuery.of(context).size.width / 3,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "id : ${id + 1}",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              Image.network(
                imgpath,
                height: 100,
              )
            ],
          ),
        ));
  }
}

class SearchBoxDex extends StatefulWidget {
  const SearchBoxDex({super.key});

  @override
  State<SearchBoxDex> createState() => _SearchBoxDexState();
}

class _SearchBoxDexState extends State<SearchBoxDex> {
  TextEditingController textEditerX = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17), // Add some padding around
      child: Row(
        children: [
          Expanded(
            // Makes TextField responsive
            child: TextField(
              keyboardType: TextInputType.number,
              controller: textEditerX,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Search...",
              ),
            ),
          ),
          const SizedBox(width: 10), // Add spacing
          ElevatedButton(
            onPressed: () {
              print("Searching for: ${textEditerX.text}");
              int? number = int.tryParse(textEditerX.text);
              if (number != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowDetailDex(number - 1),
                    ));
              }
            },
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }
}
