import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:provider_tracker/models/weight.dart';
import 'package:provider_tracker/state/weight_state.dart';

class WeightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weight Tracker Demo'),
        ),
        body: Consumer<WeightState>(
          builder: (context, state, widget) {
            var weights = state.weights;
            return Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 100.0,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Current Weight',
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              state.currentWeight.value.toString() + 'kg',
                              textScaleFactor: 2.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var weight = weights[index];
                      return ListTile(
                        title: Text(
                            '${weight.time.day}.${weight.time.month}.${weight.time.year}'),
                        trailing: Text(
                          weight.value.toString() + 'kg',
                          textScaleFactor: 2.0,
                        ),
                      );
                    },
                    itemCount: weights.length,
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var state = Provider.of<WeightState>(context, listen: false);
            var result = await showDialog<double>(
              context: context,
              builder: (context) => NumberPickerDialog.decimal(
                  minValue: 1,
                  maxValue: 200,
                  initialDoubleValue: state.weights.first.value),
            );
            if (result != null && result > 0) {
              state.add(Weight(value: result, time: DateTime.now()));
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
