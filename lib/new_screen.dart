import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:react/main.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  MyController c = Get.find(tag: 'first');
  MyController c1 = Get.put(MyController(), tag: 'second');
  MyRxController c2 = Get.put(MyRxController(), tag: 'third');
  MyRxController c3 = Get.put(MyRxController(), tag: '4');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<MyController>(
              init: c,
              initState: (_)=>print('InitState'),
              dispose: (_)=>print('Dispose'),
              builder: (_){
                return Text('c: ${_.counter.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<MyController>(
              init: c1,
              global: false,
              builder: (_){
                return Text('c1: ${_.counter.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            Obx(()=>Text('rx obx: ${c2.count.value.toString()}')),
            SizedBox(
              height: 10,
            ),
            GetX<MyRxController>(
              init: c3,
              global: false,
              builder: (controller){
                return Text('rx getX: ${c3.count.value.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(onPressed: (){c.increment();}, child: Text('c: +'),),
            SizedBox(
              height: 10,
            ),
            RaisedButton(onPressed: (){c1.increment();}, child: Text('c1: +'),),
            SizedBox(
              height: 10,
            ),
            RaisedButton(onPressed: (){c2.increment();}, child: Text('Rx Obx: +'),),
            SizedBox(
              height: 10,
            ),
            RaisedButton(onPressed: (){c3.increment();}, child: Text('Rx GetX: +'),),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
