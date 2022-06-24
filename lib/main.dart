import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lottie Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  ///dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Lottie Animation'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Lottie.asset("assets/90605-delivery-bike.json"),
          const SizedBox(
            height: 20,
          ),

          //***************Order Button*******************//
          ElevatedButton.icon(
            icon: const Icon(
              Icons.delivery_dining_outlined,
              size: 20,
            ),
            onPressed: showDialogBox,
            label: const Text('Order Now'),
            style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  //***************Dialog Function*******************//
  void showDialogBox() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Lottie.asset("assets/50465-done.json",
                  repeat: false,
                  controller: controller, onLoaded: (composition) {
                controller.forward();
              }),
              const Text(
                'Enjoy your order!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              )
            ]),
          ));
}
