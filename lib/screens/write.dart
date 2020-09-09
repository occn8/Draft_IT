import 'package:Draft_IT/index.dart';
import 'package:intl/intl.dart';

class WriteDraft extends StatefulWidget {
  final String appBarTitle;
  final Draft draft;
  WriteDraft(this.draft, this.appBarTitle);
  @override
  _WriteDraftState createState() =>
      _WriteDraftState(this.appBarTitle, this.draft);
}

class _WriteDraftState extends State<WriteDraft> {
  DataBaseHelper helper = DataBaseHelper();

  String appBarTitle;
  Draft draft;
  _WriteDraftState(this.appBarTitle, this.draft);

  static var _priorities = ['High', 'Normal'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = draft.title;
    descriptionController.text = draft.description;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(appBarTitle)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Draft Title',
                  labelStyle: TextStyle(fontWeight: FontWeight.w800),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                onChanged: (value) {
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                // controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                onChanged: (value) {
                  // updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'Notes',
                  labelStyle: TextStyle(),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Tag'),
            ),
            ListTile(
              title: DropdownButton(
                  items: _priorities.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  style: TextStyle(),
                  value: getPriorityAsString(draft.priority),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      print(valueSelectedByUser);
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  }),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _save();
                            });
                          }),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _delete();
                            });
                          }),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        draft.priority = 1;
        break;
      case 'Normal':
        draft.priority = 2;
        break;
    }
  }

  getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    draft.title = titleController.text;
  }

  void updateDescription() {
    draft.description = descriptionController.text;
  }

  void _save() async {
    Navigator.pop(context, true);
    draft.mdate = DateFormat.yMMMd().format(DateTime.now());
    draft.ddate = DateFormat.yMd().format(DateTime(2020, 7, 24));
    draft.dtime = DateFormat.Hm().format(DateTime.now());
    int result;
    if (draft.id != null) {
      result = await helper.updateDraft(draft);
    } else {
      result = await helper.insertDraft(draft);
    }
    if (result != 0) {
      // _showAlartDialog('status', 'Note saved successfully');
    } else {
      // _showAlartDialog('status', 'problem saveing note');
    }
  }

  void _delete() async {
    Navigator.pop(context, true);

    if (draft.id != null) {
      // _showAlartDialog('status', 'no Note  deleted');
      return;
    }
    int result = await helper.deleteDraft(draft.id);
    if (result != 0) {
      // _showAlartDialog('status', 'Note deleted successfully');
    } else {
      // _showAlartDialog('status', 'Error occured deleting note');
    }
  }

  // void _showAlartDialog(String title, String message) {
  //   AlertDialog alartDialog = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alartDialog);
  // }
}
