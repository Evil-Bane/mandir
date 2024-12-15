import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class generation extends StatefulWidget {
  final String imagePath;
  const generation(this.imagePath, {super.key});

  @override
  State<generation> createState() => _generationState();
}

class _generationState extends State<generation> {
  // GlobalKey for converting the widget to a PNG
  final GlobalKey _globalKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage; // Store the image picked from the gallery

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generate Image",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: _globalKey, // Key for capturing the widget
          child: Column(
            children: [
              // Stack to overlay "Add Photo" button on the image and text field
              Stack(
                children: [
                  // Image display
                  Container(
                    height: 550,
                    width: double.infinity,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Add Photo button
                  Positioned(
                    bottom: 20, // Adjust for overlap with text field
                    right: 10,
                    child: ElevatedButton(
                      onPressed: _pickImage, // Open gallery on click
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.zero,
                        fixedSize: Size(50, 50), // Square button
                      ),
                      child: Icon(Icons.add_a_photo, size: 24),
                    ),
                  ),
                ],
              ),
              // Name TextField (strap)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Enter your name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // "Generate Photo" button
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your generate PNG logic here
                  },
                  child: Text("Generate Photo"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
