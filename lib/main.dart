import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:react/new_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyController c = Get.put(MyController(), tag: 'first');
  MyController c1 = Get.put(MyController(), tag: 'second');
  MyRxController c2 = Get.put(MyRxController(), tag: 'third');
  MyRxController c3 = Get.put(MyRxController(), tag: '4');

  @override
  void initState() {
    c3.count.listen((p0) {
      print(p0.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<MyController>(
              init: c,
              initState: (_) => print('InitState'),
              dispose: (_) => print('Dispose'),
              builder: (_) {
                return Text('c: ${_.counter.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            GetBuilder<MyController>(
              init: c1,
              global: false,
              builder: (_) {
                return Text('c1: ${_.counter.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Text('rx obx: ${c2.count.value.toString()}')),
            SizedBox(
              height: 10,
            ),
            GetX<MyRxController>(
              init: c3,
              global: false,
              builder: (controller) {
                return Text('rx getX: ${c3.count.value.toString()}');
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                c.increment();
              },
              child: Text('c: +'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                c1.increment();
              },
              child: Text('c1: +'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                c2.increment();
              },
              child: Text('Rx Obx: +'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                c3.increment();
              },
              child: Text('Rx GetX: +'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                Get.to(() => NewScreen());
              },
              child: Text('Next Screen'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyController extends GetxController {
  int _counter = 0;

  void increment() {
    _counter++;
    update();
  }

  int get counter => _counter;
}

class MyRxController extends GetxController {
  Rx<int> count = 0.obs;

  void increment() {
    count.value++;
  }
}
