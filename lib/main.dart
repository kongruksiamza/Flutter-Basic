import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';
import 'MoneyBox.dart';

void main() {
  runApp(MyApp());
}

// สร้าง widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  ExchangeRate _dataFromAPI;
  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }
  Future <ExchangeRate> getExchangeRate() async{
     var url = "https://api.exchangeratesapi.io/latest?base=THB";
     var response=await http.get(url);
     _dataFromAPI=exchangeRateFromJson(response.body);//json => dart object
     return _dataFromAPI;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แปลงสกุลเงิน",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body:FutureBuilder(
          future: getExchangeRate(),
          builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
            //ดึงข้อมูลจาก getExchangeRate มาครบเรียบร้อยจะให้ทำอะไร  
            if(snapshot.connectionState == ConnectionState.done){
                var result = snapshot.data;
                double amount=10000;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children: [
                        MoneyBox("สกุลเงิน (THB)",amount,Colors.lightBlue,150),
                        SizedBox(height: 5,),
                        MoneyBox("USD", amount*result.rates["USD"], Colors.green, 100),
                        SizedBox(height: 5,),
                        MoneyBox("EUR", amount*result.rates["EUR"], Colors.red, 100),
                        SizedBox(height: 5,),
                        MoneyBox("GBP", amount*result.rates["GBP"], Colors.pink, 100),
                         SizedBox(height: 5,),
                        MoneyBox("JPY", amount*result.rates["JPY"], Colors.orange, 100),
                      ],
                  ),
                );
            }
            return LinearProgressIndicator();
        },)
        );
  }
}
