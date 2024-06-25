import 'package:flutter/material.dart';
import 'util/converted_util.dart';


void main()=> runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState(
  );
}
  class MyAppState extends State<MyApp>{
    late double _numberForm;
    String? _startMeasure;
    String? _convertedMeasure;
    double _result = 0;
    String? _resultMessage = '';

    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];
  @override
  void initState(){
    _numberForm = 0;
    super.initState();
  }

  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY/40));
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );
    return MaterialApp(
      title: 'Measures converter',
      home: Scaffold(
        appBar: AppBar(
            title: Text('Measures converter'),
            backgroundColor: Colors.redAccent
        ),
        body: Container(
          width: sizeX,
          padding: EdgeInsets.all(sizeX/20),
          // child: SingleChildScrollView(
          child: Column(
              children: [
                Text('Value', style: labelStyle,),
               spacer,
                TextField(
                  style: inputStyle,
                  decoration: const InputDecoration(
                    hintText: "Please insert the measure to be converted",
                  ),
                  onChanged: (text) {
                    setState(() {
                      _numberForm = double.parse(text);
                    });
                  },
                ),
                spacer,
                Text('From', style: labelStyle,),
                spacer,
                DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  value: _startMeasure,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: inputStyle,),
                    );
                  }).toList(),
                  onChanged: (value) {
                    onStartMeasureChanged(value!);
                  },
                ),
                spacer,
                Text('To', style: labelStyle,),
                spacer,
                DropdownButton(
                  isExpanded: true,
                  style: inputStyle,
                  value: _convertedMeasure,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: inputStyle,),
                    );
                  }).toList(),
                  onChanged: (value) {
                    onConvertedMeasureChanged(value!);
                  },
                ),
          const Spacer( flex: 2,),

          ElevatedButton(onPressed:()=>convert(), child: Text('convert', style: inputStyle,)),
                Text(_resultMessage!, style: labelStyle,),

         const Spacer(flex: 2,),
          Text((_numberForm!=null) ? '' : _numberForm.toString(), style: labelStyle,),
                const Spacer(flex: 8,)

        ]
          )
        ),
      ),
    );

  }
    void onStartMeasureChanged(String value) {
      setState(() {
        _startMeasure = value;
      });
    }
    void onConvertedMeasureChanged(String value) {
      setState(() {
        _convertedMeasure = value;
      });
    }
    void convert() {
      if (_startMeasure!.isEmpty || _convertedMeasure!.isEmpty || _numberForm==0) {
        return;
      }
      Conversion c = Conversion();
      double result = c.convert(_numberForm, _startMeasure!, _convertedMeasure!);
      setState(() {
        _result = result;
        if (result == 0) {
          _resultMessage = 'This conversion cannot be performed';
        }
        else {
          _resultMessage = '${_numberForm.toString()} $_startMeasure '
              '${_result.toString()} $_convertedMeasure';
        }

      });
}
}

