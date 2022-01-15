import 'dart:async';

import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  late List<Map<String, dynamic>> listPerson = [
    {"name": "Teo", "age": 10},
    {"name": "Ti", "age": 12},
    {"name": "Tun", "age": 14},
    {"name": "Tuan", "age": 16},
  ];

  StreamController<String> text = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View Screen"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController nameController =
                          TextEditingController();
                      TextEditingController ageController =
                          TextEditingController();
                      return Dialog(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Them du lieu moi"),
                              SizedBox(height: 10),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                              SizedBox(height: 10),
                              StreamBuilder(
                                  initialData: null,
                                  stream: text.stream,
                                  builder: (context , snapshot){
                                    if(snapshot.hasError){
                                      return TextField(
                                          controller: ageController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Age',
                                              errorText: snapshot.error.toString()
                                          )
                                      );
                                    }
                                    return TextField(
                                      controller: ageController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Age',
                                      ),
                                    );
                                  }
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Huy")),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          String name =
                                              nameController.text.toString();
                                          String age =
                                              ageController.text.toString();

                                          if(age.isEmpty){
                                            text.sink.addError("Empty");
                                            return;
                                          }

                                          setState(() {
                                            listPerson.add(
                                                {"name": name, "age": age});
                                            Navigator.pop(context);

                                          });
                                        });
                                      },
                                      child: Text("Luu")),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: ListView.builder(
            itemCount: listPerson.length,
            itemBuilder: (context, position) {
              return Card(
                child: ListTile(
                  title: Text('Name : ${listPerson[position]["name"]}'),
                  subtitle: Text('Age : ${listPerson[position]["age"]}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        listPerson.removeAt(position);
                      });
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
