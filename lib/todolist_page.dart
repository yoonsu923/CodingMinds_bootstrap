import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodolistPage extends StatefulWidget {
  @override
  _TodolistPageState createState() => _TodolistPageState();
}


class _TodolistPageState extends State<TodolistPage> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    FirebaseFirestore.instance.collection("todos").add({
      "title":_controller.text
    });
  }

  onDelete(String id) {
    FirebaseFirestore.instance.collection("todos").doc(id).delete();
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Type here"),
          ),
        ),
        TextButton(onPressed: () {
          _addTask();
          },
            child: Text("add Task")),
      ],
    ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("todos").snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            else{
              return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((document){
                      return Dismissible(
                        key: Key(document.id),
                        onDismissed: (direction) {
                          onDelete(document.id);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(Icons.delete),
                        ),
                      child: ListTile(
                      title: Text(document["title"]),
                      ),
                      );
                    }).toList(),
                  ),
              );
            }
          }
        )

    ]
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do list"),
      ),
      body: _buildBody(context),

    );
  }
}