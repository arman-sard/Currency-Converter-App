// ignore_for_file: prefer_const_constructors

import 'package:currency_app/components/anyToAny.dart';
import 'package:currency_app/functions/fetchrates.dart';
import 'package:currency_app/models/ratesmodel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Initial Variables

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  //Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      //Future Builder for Getting Exchange Rates
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.fromLTRB(15, 60, 15, 50),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formkey,
                child: FutureBuilder<RatesModel>(
                  future: result,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.grey,
                          ),
                        ),
                      ));
                    }
                    return Center(
                      child: FutureBuilder<Map>(
                          future: allcurrencies,
                          builder: (context, currSnapshot) {
                            if (currSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                              ));
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnyToAny(
                                  currencies: currSnapshot.data!,
                                  rates: snapshot.data!.rates,
                                ),
                              ],
                            );
                          }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
