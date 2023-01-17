import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';

class NoteEditor extends StatefulWidget {
  NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  @override
  Widget build(BuildContext context) {
    int color_id = Random().nextInt(AppStyle.cardsColor.length);
    String data = DateTime.now().toString();

    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Add a new Note" , style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border : InputBorder.none,
                hintText: "Note Tile"
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 5,),

            Text(data , style: AppStyle.dataTitle,),

            const SizedBox(height: 30,),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border : InputBorder.none,
                hintText: "Note Content"
              ),
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async{
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title" : _titleController.text,
            "creating_data" : data,
            "note_content" : _mainController.text,
            "color_id" : color_id
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
            (error) => print("Failed to add new Note to $error")
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}