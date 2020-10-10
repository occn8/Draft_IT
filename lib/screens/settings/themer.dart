import 'package:Draft_IT/index.dart';

Future<String> themer(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Choose Theme'),
      children: <Widget>[
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
            itemCount: Themes.values.length,
            itemExtent: 50,
            itemBuilder: (BuildContext context, int index) {
              final theme = Themes.values[index];
              return Card(
                color: Theme.of(context).cardColor,
                child: Consumer<ThemeChanger>(
                  builder: (context, notifier, child) => InkWell(
                      onTap: () {
                        notifier.setTheme(theme);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          themesData[theme] == notifier.themeData
                              ? Icon(
                                  Icons.radio_button_checked,
                                  color: themesData[theme].primaryColor,
                                )
                              : Icon(Icons.radio_button_unchecked),
                          SizedBox(width: 10),
                          Text(
                            enumName(theme),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}
