// ignore_for_file: prefer_const_constructors
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:currency_app/functions/fetchrates.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnyToAny({Key? key, required this.rates, required this.currencies})
      : super(key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'EUR';
  String dropdownValue2 = 'USD';
  String answer = '';
  BoxShadow morfDark = BoxShadow(
    color: Colors.grey.shade500,
    offset: const Offset(4, 4),
    blurRadius: 15,
    spreadRadius: 1,
  );
  BoxShadow morfLight = BoxShadow(
    color: Colors.white,
    offset: Offset(-4, -4),
    blurRadius: 15,
    spreadRadius: 1,
  );
 

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    return Container(
      // width: w / 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: Colors.grey[300],
          boxShadow: [morfDark, morfLight]),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Currency Converter',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 10),
          // TextFields for Entering amount
          TextFormField(
            key: ValueKey('amount'),
            controller: amountController,
            decoration: InputDecoration(
              hintText: 'Enter Amount',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 15),
          // Currency art
          Row(
            children: [
              Expanded(
                child: DropdownButton2<String>(
                  offset: const Offset(-15, -180),
                  scrollbarAlwaysShow: true,
                  selectedItemHighlightColor: Colors.grey[350],
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                      boxShadow: [morfDark, morfLight]),
                  dropdownMaxHeight: 415,
                  dropdownWidth: 150,
                  value: dropdownValue1,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  iconSize: 28,
                  isExpanded: true,
                  underline: Container(
                    height: 1.3,
                    color: Colors.grey.shade500,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To')),
              Expanded(
                child: DropdownButton2<String>(
                  offset: const Offset(0, -180),
                  scrollbarAlwaysShow: true,
                  selectedItemHighlightColor: Colors.grey[350],
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                      boxShadow: [morfDark, morfLight]),
                  dropdownMaxHeight: 415,
                  dropdownWidth: 150,
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  iconSize: 28,
                  isExpanded: true,
                  underline: Container(
                    height: 1.3,
                    color: Colors.grey.shade500,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: widget.currencies.keys
                      .toSet()
                      .toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(value),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          // Buttons
          Row(
            children: [
              // Converter button
              NeumorphicButton(
                style: NeumorphicStyle(color: Colors.grey[300]),
                onPressed: () {
                  setState(() {
                    amountController.text == ''
                        ? null
                        :

                        // converted result in UI
                        answer = amountController.text +
                            ' ' +
                            dropdownValue1 +
                            ' ' +
                            ' =  ' +
                            convertany(widget.rates, amountController.text,
                                dropdownValue1, dropdownValue2) +
                            ' ' +
                            dropdownValue2;
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text('Convert'),
                ),
              ),
              Spacer(),
              // Swap button
              NeumorphicButton(
                style: NeumorphicStyle(color: Colors.grey[300]),
                onPressed: () {
                  String temp = dropdownValue1;
                  setState(() {
                    // swap currency
                    dropdownValue1 = dropdownValue2;
                    dropdownValue2 = temp;

                    // converted result in UI
                    amountController.text == ''
                        ? null
                        : answer = amountController.text +
                            ' ' +
                            dropdownValue1 +
                            ' ' +
                            ' =  ' +
                            convertany(widget.rates, amountController.text,
                                dropdownValue1, dropdownValue2) +
                            ' ' +
                            dropdownValue2;
                  });
                },
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
                    child: Icon(Icons.swap_horiz)),
              )
            ],
          ),
          SizedBox(height: 25),
          // Converted result field
          Neumorphic(
            style: NeumorphicStyle(
                depth: -5,
                shadowLightColorEmboss: Colors.white,
                shadowDarkColorEmboss: Colors.grey,
                color: Colors.grey[300]),
            child: Center(
              child: Container(
                height: 50,
                color: Colors.grey[300],
                child: Center(child: Text(answer)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
