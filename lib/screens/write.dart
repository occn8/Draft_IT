import 'package:Draft_IT/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  DataBaseHelper helper = DataBaseHelper();
  FocusNode _titleFocus, _descriptionFocus, _todoFocus, _noteFocus;
  String appBarTitle;
  Draft draft;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController todoController = TextEditingController();
  static var _priorities = ['Low', 'Normal','High'];
  int _radiaVal = 1;

  _WriteDraftState(this.appBarTitle, this.draft);

  @override
  void initState() {
    super.initState();
    initializing();
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    _noteFocus = FocusNode();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    _noteFocus.dispose();
    super.dispose();
  }

  void initializing() async {
    androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, titleController.text,
        descriptionController.text, notificationDetails);
  }

  void _showNotificationsAfterSecond() async {
    await notificationAfterSec();
  }

  Future<void> notificationAfterSec() async {
    var timeDelayed = DateTime(2020, 9, 11, 22, 15).add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
        'please subscribe my channel', timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = draft.title;
    descriptionController.text = draft.description;
    notesController.text = draft.notes;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: ListView(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: new EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            // color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: new Icon(Icons.arrow_back_ios,
                            size: 25,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ),
                  Text(
                    appBarTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {},
                      child: Container(
                        padding: new EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            // color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: new Icon(Icons.more_horiz,
                            size: 25,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(draft.id.toString()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                focusNode: _titleFocus,
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(),
                onChanged: (value) {
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Draft Title',
                  hintText: 'Enter Title',
                  prefixIcon: Icon(Icons.title),
                  labelStyle: TextStyle(fontWeight: FontWeight.w800),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                focusNode: _descriptionFocus,
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
                  hintText: 'Enter Description',
                  labelStyle: TextStyle(),
                  prefixIcon: Icon(Icons.description),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: notesController,
                focusNode: _noteFocus,
                maxLines: null,
                minLines: 3,
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
                        style: TextStyle(
                            color: Theme.of(context).primaryColorDark),
                      ),
                      value: dropDownStringItem,
                    );
                  }).toList(),
                  style: TextStyle(),
                  value: getPriorityAsString(draft.priority),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      print(draft.priority);
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  }),
            ),
            Row(
              children: <Widget>[
                for (int i = 0; i <_priorities.length; i++)
                  Container(
                    color: Colors.amber,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            _priorities[i],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Container(
                          child: Radio(
                            value: i,
                            groupValue: this._radiaVal,
                            activeColor: Color(0xFF6200EE),
                            onChanged: (int value) {
                              setState(() {
                                this._radiaVal = value;
                                print(_radiaVal);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FutureBuilder(
            //     future: helper.getTodo(draft.id),
            //     initialData: [],
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
            //       return Container(
            //         height: 100,
            //         child: Scrollbar(
            //           child: ListView.builder(
            //             itemCount: snapshot.data.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return GestureDetector(
            //                   onTap: () async {
            //                     if (snapshot.data[index].isDone == 0) {
            //                       await helper.updateTodoDone(
            //                           snapshot.data[index].id, 1);
            //                     } else {
            //                       await helper.updateTodoDone(
            //                           snapshot.data[index].id, 0);
            //                     }
            //                     setState(() {});
            //                   },
            //                   child: Container(
            //                     padding: EdgeInsets.symmetric(
            //                       horizontal: 24.0,
            //                       vertical: 8.0,
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         Container(
            //                           width: 20.0,
            //                           height: 20.0,
            //                           margin: EdgeInsets.only(
            //                             right: 12.0,
            //                           ),
            //                           decoration: BoxDecoration(
            //                               color: snapshot.data[index].isDone
            //                                   ? Color(0xFF7349FE)
            //                                   : Colors.transparent,
            //                               borderRadius:
            //                                   BorderRadius.circular(6.0),
            //                               border: snapshot.data[index].isDone
            //                                   ? null
            //                                   : Border.all(
            //                                       color: Color(0xFF86829D),
            //                                       width: 1.5)),
            //                           child: Icon(Icons.check_box),
            //                         ),
            //                         Flexible(
            //                           child: Text(
            //                             snapshot.data[index].title ?? "(Unnamed Todo)",
            //                             style: TextStyle(
            //                               color: snapshot.data[index].isDone
            //                                   ? Color(0xFF211551)
            //                                   : Color(0xFF86829D),
            //                               fontSize: 16.0,
            //                               fontWeight:
            //                                   snapshot.data[index].isDone
            //                                       ? FontWeight.bold
            //                                       : FontWeight.w500,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ));
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // TextField(
            //   focusNode: _todoFocus,
            //   controller: todoController,
            //   onSubmitted: (value) async {
            //     if (value != "") {
            //       if (draft.id != null) {
            //         Todo _newTodo = Todo(
            //           draftId: draft.id,
            //           title: value,
            //           isDone: 0,
            //         );
            //         await helper.insertTodo(_newTodo);
            //         setState(() {});
            //         print("Task exist");
            //         // _todoFocus.requestFocus();
            //       } else {
            //         print("Task doesn't exist");
            //       }
            //     }
            //   },
            //   decoration: InputDecoration(
            //     hintText: "Enter Todo item...",
            //     border: InputBorder.none,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Time'),
                  SizedBox(width: 5),
                  Text('Day'),
                ],
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: _showNotificationsAfterSecond,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onPressed: () {
                          setState(() {
                            _save();
                          });
                        }),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Low':
        draft.priority = 0;
        break;
      case 'Normal':
        draft.priority = 1;
        break;
      case 'High':
        draft.priority = 2;
        break;
    }
  }

  getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 0:
        priority = _priorities[0];
        break;
      case 1:
        priority = _priorities[1];
        break;
      case 2:
        priority = _priorities[2];
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
    Navigator.pop(context);
    draft.mdate = DateFormat.yMMMd().format(DateTime.now());
    draft.ddate =
        DateFormat.yMd().format(DateTime(2020, 7, 24));
    draft.dtime = DateFormat.Hm().format(DateTime.now());
    int result;
    if (draft.id != null) {
      result = await helper.updateDraft(draft);
    } else {
      // result = await helper.insertDraft(draft);
    }
    if (result != 0) {
      // _showAlartDialog('status', 'Note saved successfully');
    } else {
      // _showAlartDialog('status', 'problem saveing note');
    }
  }

  // void _delete() async {
  //   Navigator.pop(context, true);

  //   if (draft.id != null) {
  //     // _showAlartDialog('status', 'no Note  deleted');
  //     return;
  //   }
  //   int result = await helper.deleteDraft(draft.id);
  //   if (result != 0) {
  //     // _showAlartDialog('status', 'Note deleted successfully');
  //   } else {
  //     // _showAlartDialog('status', 'Error occured deleting note');
  //   }
  // }

  // void _showAlartDialog(String title, String message) {
  //   AlertDialog alartDialog = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   showDialog(context: context, builder: (_) => alartDialog);
  // }
}
