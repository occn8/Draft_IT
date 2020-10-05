import 'package:Draft_IT/index.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
            child: Container(
          child: ListView.builder(
            itemCount: Themes.values.length,
            itemBuilder: (BuildContext context, int index) {
              final theme = Themes.values[index];
              return Card(
                color: themesData[theme].primaryColor,
                child: Consumer<ThemeChanger>(
                  builder: (context, notifier, child) => InkWell(
                      onTap: () {
                        notifier.setTheme(theme);
                      },
                      child: ListTile(
                        title: Text(
                          enumName(theme),
                          style: themesData[theme].textTheme.bodyText1,
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
