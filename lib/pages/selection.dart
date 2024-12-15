import 'package:flutter/material.dart';
import 'package:mandir/pages/generation.dart';

class selection extends StatefulWidget {
  const selection({super.key});

  @override
  State<selection> createState() => _selectionState();
}

class _selectionState extends State<selection> {
  final List<String> images = ['assets/1.jpg', 'assets/2.jpg','assets/3.webp','assets/4.jpeg','assets/5.jpeg','assets/6.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Wallpaper", style: TextStyle(color: Colors.white,)),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50,left: 20, right: 20),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
    itemCount: 6,
    itemBuilder: (context, index){
    return GestureDetector(
    onTap: () {
    Navigator.pushNamed(context, "/gen", arguments: images[index].toString());
    },
    child: Container(
    decoration: BoxDecoration(
    color: Colors.grey[300],
      borderRadius: BorderRadius.circular(50),
    ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(images[index], fit: BoxFit.cover,),
      ),
    )
    );
    },
        ),
      ),
    );
  }
}
