import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Trip Cost Calculator",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  var currencies = ["Dollars", "Euro", "Mad"];
  var _currency = "Mad";
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Devteam cost calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: FORM_DISTANCE, bottom: FORM_DISTANCE),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                      hintText: DISTANCE_EXAMPLE,
                      labelText: DISTANCE,
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding:
                    EdgeInsets.only(top: FORM_DISTANCE, bottom: FORM_DISTANCE),
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                      hintText: DISTANCE_EXAMPLE,
                      labelText: DISTANCE_PER_UNIT,
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding:
                    EdgeInsets.only(top: FORM_DISTANCE, bottom: FORM_DISTANCE),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          hintText: DISTANCE_EXAMPLE,
                          labelText: PRICE,
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                    )),
                    Container(width: FORM_DISTANCE * 5),
                    Expanded(
                        child: DropdownButton<String>(
                            items: this.currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            value: _currency,
                            onChanged: (String value) {
                              _onDropDownChanged(value);
                            }))
                  ],
                )),
            Row(children: <Widget>[
              Expanded(
                  child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  'Submit',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  setState(() {
                    result = _calculate();
                  });
                },
              )),
              Container(
                width: FORM_DISTANCE * 5.0,
              ),
              Expanded(
                  child: RaisedButton(
                color: Theme.of(context).buttonColor,
                textColor: Theme.of(context).primaryColorDark,
                child: Text(
                  'Reset',
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
              ))
            ]),
            Text(result),
          ],
        ),
      ),
    );
  }

  void _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  void _reset() {
    distanceController.text = '';
    priceController.text = '';
    avgController.text = '';
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelCost;

    return 'The total cost of your trip is ' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        _currency;
  }
}
