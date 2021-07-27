import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/model/todo_model.dart';

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final Function onSave;
  final Todo? todo;
  const AddEditPage(
      {Key? key,
      required this.isEditing,
      required this.onSave,
      required this.todo})
      : super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _noteEditingController = TextEditingController();
  String? _title;
  String? _note;

  @override
  void initState() {
    _titleEditingController.text = widget.isEditing ? widget.todo!.title : '';
    _noteEditingController.text = widget.isEditing ? widget.todo!.note : '';
    super.initState();
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _noteEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _titleEditingController,
              decoration: InputDecoration(hintText: 'Enter Titile'),
              onChanged: (v) => _title = v,
            ),
            TextField(
              controller: _noteEditingController,
              decoration: InputDecoration(hintText: 'Enter Titile'),
              onChanged: (v) => _note = v,
            ),
            ElevatedButton(
                onPressed: () {
                  widget.onSave(_title, _note);
                  Navigator.pop(context);
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
