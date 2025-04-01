import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> getDataAll() async {
  var url = "https://pokeapi.co/api/v2/pokedex/1/";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body)['pokemon_entries'] as List;

    return data;
  } else {
    throw Exception("Error connact");
  }
}

Future<Map<String, dynamic>> getDataDetail(id) async {
  id = id.toString();
  var url = "https://pokeapi.co/api/v2/pokemon-species/$id/";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // print(data);
    return data;
  } else {
    throw Exception("Error connact");
  }
}
