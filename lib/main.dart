import 'dart:convert';

import 'package:data_app/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  FocusNode feedFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  final form_key = GlobalKey<FormState>();
  Map<String, dynamic> data = Map();
  Future<User> fetchdata() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Decode the JSON string into a Map before passing it to fromJson
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load data with status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  // Return an empty user or handle the error as needed
  return User();
}
  Future<String> postdata() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'title': 'Mahdi'}),
        headers: {'Content-type': 'application/json'},
      );
      print('response==>${response.body}');
      if (response.statusCode == 200) {
        print('Data : ${response.body}');
      } else {
        print('${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return 'Data save Successfully';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: form_key,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (form_key.currentState!.validate()) {
                      var msg = await postdata();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(msg)));
                    }
                  },
                  child: Text('Submit data'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (form_key.currentState!.validate()) {
                      var msg = await fetchdata();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(msg.title.toString())));
                    }
                  },
                  child: Text('Get data'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
