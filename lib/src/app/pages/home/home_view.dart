import 'package:flutter/material.dart';
import 'package:pace_calculator/src/app/pages/home/home_view_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MyHomePage(title: 'Pace Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _model = HomeViewModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
        model: _model,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ScopedModelDescendant<HomeViewModel>(
                builder: (context, child, model) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildUpperContainer(context, model, _formKey),
                  _buildPaceDashboard(context, model)
                ],
              );
            })));
  }

  Container _buildUpperContainer(
      BuildContext context, HomeViewModel model, GlobalKey<FormState> formKey) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Calculate your running pace",
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Expected Pace Per',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.directions_run),
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    _buildForm(model, formKey),
                    Padding(padding: EdgeInsets.all(8.0)),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: RaisedButton(
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            final form = formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              model.save();
                            }
                          },
                          color: Colors.blueAccent),
                    ),
                    Padding(padding: EdgeInsets.all(8.0))
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Form _buildForm(HomeViewModel model, GlobalKey<FormState> formKey) {
    return Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(8.0)),
            Flexible(
                child: TextFormField(
                    initialValue: "5",
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        suffixText: "minutes"),
                    onSaved: (String value) => model.setMinutes(value),
                    validator: (String value) {
                      return int.tryParse(value) != null
                          ? null
                          : 'Please type in a number';
                    })),
            Padding(padding: EdgeInsets.all(5.0)),
            Flexible(
                child: TextFormField(
                    initialValue: "00",
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        suffixText: "seconds"),
                    onSaved: (String value) => model.setSeconds(value),
                    validator: (String value) {
                      return int.tryParse(value) != null
                          ? null
                          : 'Please type in a number';
                    })),
            Padding(padding: EdgeInsets.all(8.0))
          ],
        ));
  }

  Container _buildPaceDashboard(BuildContext context, HomeViewModel model) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildPaceTable(model)]));
  }

  DataTable _buildPaceTable(HomeViewModel model) {
    return DataTable(columns: [
      DataColumn(label: Text("Distance")),
      DataColumn(label: Text("Time / (min:ss)"))
    ], rows: [
      DataRow(cells: [
        DataCell(Text("400m")),
        DataCell(Text("1:30")),
      ])
    ]);
  }
}
