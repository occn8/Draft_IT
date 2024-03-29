import 'package:Draft_IT/index.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graphs extends StatefulWidget {
  @override
  _GraphsState createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  bool _animate = true;
  bool _defaultInteractions = true;
  double _arcRatio = 0.8;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;

  List<_CostsData> _data = [
    _CostsData('housing', 1000),
    _CostsData('food', 500),
    _CostsData('health', 200),
    _CostsData('trasport', 100),
  ];

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this._data.length);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(
              title: 'Graphs',
              leadOnTap: () {
                Navigator.pop(context);
              },
              leadIcon: Icons.arrow_back_ios,
              trailIcon: Icons.more_horiz,
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: charts.PieChart(
                [
                  charts.Series<_CostsData, String>(
                    id: 'Sales-1',
                    colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                    domainFn: (_CostsData sales, _) => sales.category,
                    measureFn: (_CostsData sales, _) => sales.cost,
                    data: this._data,
                    labelAccessorFn: (_CostsData row, _) =>
                        '${row.category}: ${row.cost}',
                  ),
                ],
                animate: this._animate,
                defaultRenderer: new charts.ArcRendererConfig(
                  arcRatio: this._arcRatio,
                  arcRendererDecorators: [
                    charts.ArcLabelDecorator(
                        labelPosition: this._arcLabelPosition)
                  ],
                ),
                behaviors: [
                  charts.ChartTitle(
                    'Dummy costs breakup',
                    behaviorPosition: this._titlePosition,
                  ),
                  // Add legend. ("Datum" means the "X-axis" of each data point.)
                  charts.DatumLegend(
                    position: this._legendPosition,
                    desiredMaxRows: 2,
                  ),
                ],
              ),
            ),
            Divider(),
            ..._controlWidgets(),
          ],
        ),
      ),
    );
  }

  List<Widget> _controlWidgets() => <Widget>[
        SwitchListTile(
          title: Text('animate'),
          onChanged: (bool val) => setState(() => this._animate = val),
          value: this._animate,
        ),
        SwitchListTile(
          title: Text('defaultInteractions'),
          onChanged: (bool val) =>
              setState(() => this._defaultInteractions = val),
          value: this._defaultInteractions,
        ),
        ListTile(title: Text('Arc width ratio w.r.t. radius:')),
        Slider(
          divisions: 10,
          onChanged: (double val) => setState(() => this._arcRatio = val),
          value: this._arcRatio,
          label: '${this._arcRatio}',
        ),
        ListTile(
          title: Text('arcLabelPosition:'),
          trailing: DropdownButton<charts.ArcLabelPosition>(
            value: this._arcLabelPosition,
            onChanged: (charts.ArcLabelPosition newVal) {
              if (newVal != null) {
                setState(() => this._arcLabelPosition = newVal);
              }
            },
            items: [
              for (final val in charts.ArcLabelPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
        ListTile(
          title: Text('titlePosition:'),
          trailing: DropdownButton<charts.BehaviorPosition>(
            value: this._titlePosition,
            onChanged: (charts.BehaviorPosition newVal) {
              if (newVal != null) {
                setState(() => this._titlePosition = newVal);
              }
            },
            items: [
              for (final val in charts.BehaviorPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
        ListTile(
          title: Text('legendPosition:'),
          trailing: DropdownButton<charts.BehaviorPosition>(
            value: this._legendPosition,
            onChanged: (charts.BehaviorPosition newVal) {
              if (newVal != null) {
                setState(() => this._legendPosition = newVal);
              }
            },
            items: [
              for (final val in charts.BehaviorPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
      ];
}

class _CostsData {
  final String category;
  final int cost;

  const _CostsData(this.category, this.cost);
}
