import 'package:Draft_IT/index.dart';

class AddTag extends StatefulWidget {
  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  DataBaseHelper dbhelper = DataBaseHelper();

  TextEditingController tagController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  FocusNode _tagFocus, _descriptionFocus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  focusNode: _tagFocus,
                  controller: tagController,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(),
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Tag Name',
                    hintText: 'Enter Tag Name',
                    prefixIcon: Icon(Icons.title),
                    labelStyle: TextStyle(fontWeight: FontWeight.w800),
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Add Tag',
                    textScaleFactor: 1.5,
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  onPressed: () async {
                    Tag tag = Tag(tagController.text);
                    await dbhelper.insertTag(tag);
                    // Navigator.pop(context);
                    tagController.clear();
                  }),
             
            ],
          ),
        ),
      ),
    );
  }
}
 // FutureBuilder(
              //   future: dbhelper.getTagList(),
              //   initialData: [],
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     return ListView.builder(
              //       itemCount: snapshot.data.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return ListTile(
              //           title: Text(snapshot.data[index].name),
              //         );
              //       },
              //     );
              //   },
              // ),