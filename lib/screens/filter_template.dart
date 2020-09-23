import 'package:Draft_IT/index.dart';
import 'package:Draft_IT/widgets/future_draftbuilder.dart';

class FilteredTemplate extends StatefulWidget {
  final String strFilter;
  const FilteredTemplate({this.strFilter});

  @override
  _FilteredTemplateState createState() => _FilteredTemplateState();
}

class _FilteredTemplateState extends State<FilteredTemplate> {
  List<Draft> drafts;
  DataBaseHelper dbhelper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            CustomAppBar(
              title: widget.strFilter == 'isStarred'
                  ? 'Starred'
                  : widget.strFilter == 'isArchived'
                      ? 'Archive'
                      : widget.strFilter == 'isTrash'
                          ? 'Trash'
                          : widget.strFilter,
              leadOnTap: () {
                Navigator.pop(context);
              },
              leadIcon: Icons.arrow_back_ios,
              trailIcon: Icons.more_horiz,
            ),
            SizedBox(height: 5),
            FutureDraftBuilder(
              future: dbhelper.getFilteredDraftList(widget.strFilter),
              strFilter: widget.strFilter,
            ),
          ],
        ),
      ),
    );
  }
}
