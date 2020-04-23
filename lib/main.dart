import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Users> fetchAlbum() async {
  final response =
  await http.get('https://jsonplaceholder.typicode.com/users');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Users.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load list');
  }
}
class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;


  Users({this.id, this.name, this.username, this.email, this.phone });

  Users.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'];


  Map toJson() {
    return {'id': id, 'name': name, 'username': username,'email': email,'phone': phone };
  }
}
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Users> futureUsers;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data from JSON User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data from JSON User List'),
        ),
        body: Center(
          child: FutureBuilder<Users>(
            future: futureUsers,
            builder:(context, index) {
                  // By default, show a loading spinner.
              return

                ListTile(leading: Container(
              width: 70.0,
              height: 70.0,
                  decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")
              )
              ),
                ));

            }
          ),
        ),
      ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  final List<Users> listScreen;

  DetailScreen({Key key, @required this.listScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: listScreen.length,
        itemBuilder: (context, index) {
          return ListTile(leading: Container(
          width: 70.0,
          height: 70.0,
              decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")
          )
          ),
          ),
          title: Text(listScreen[index].name),
          subtitle: Text(listScreen[index].email),

          onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigateScreen(userList: listScreen[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NavigateScreen extends StatelessWidget {
  // Declare a field that holds the list.
  final Users userList;


  NavigateScreen({Key key, @required this.userList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userList.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
        Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage("https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")
            )
        ),
      ),
      Text(userList.username),
      Text(userList.email),
      Text(userList.phone),
        ]
        ),
      ),
    );

  }
}

