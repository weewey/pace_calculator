import 'package:flutter/material.dart';
import 'package:pace_calculator/src/app/pages/home/home_view_model.dart';
import 'package:pace_calculator/src/duration_helpers.dart';
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView.builder(
                              shrinkWrap: true,
                                itemCount: model.runs.length,
                                itemBuilder: (BuildContext context, int index){
                              return ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Icon(Icons.directions_run, size: 50, color: Colors.lightBlueAccent),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text("Duration: ${DurationHelpers.getReadableString(model.runs[index].duration)}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Distance: ${model.runs[index].distance}km", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold) ,),
                                ),
                              );
                            }),
                          ),
                        ],
                      )
                    ]);
              },
            )));
  }

  Container _buildUpperContainer(BuildContext context, HomeViewModel model,
      GlobalKey<FormState> formKey) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
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

}
