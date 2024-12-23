import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class Generation extends StatefulWidget {
  final String imagePath;
  const Generation(this.imagePath, {Key? key}) : super(key: key);

  @override
  State<Generation> createState() => _GenerationState();
}

class _GenerationState extends State<Generation> {
  final FocusNode _textFieldFocusNode = FocusNode();
  final WidgetsToImageController _controller = WidgetsToImageController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Uint8List? _capturedImageBytes;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }
  Future<void> _saveImage(Uint8List? _capturedImageBytes) async {
    if (_capturedImageBytes == null) return; // Handle null case
    await Permission.storage.request();
    await ImageGallerySaverPlus.saveImage(_capturedImageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate Image"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
            children: [
              WidgetsToImage(
                controller: _controller,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 550,
                      width: double.infinity,
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 500),
                      child: TextField(
                        focusNode: _textFieldFocusNode,
                        decoration: const InputDecoration(
                            hintText: "Enter your name",
                            filled: true,
                            fillColor: Colors.black
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'RubikWetPaint'
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 120,
                              height: 120,
                              color: Colors.grey[300],
                              child: _selectedImage == null
                                  ? Center(
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              )
                                  : Image.file(
                                File(_selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              if (_capturedImageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 0),
                  child: Image.memory(
                    _capturedImageBytes!,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 255,),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    _selectedImage == null
                        ? "Add Photo"
                        : "Replace Photo",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          _textFieldFocusNode.unfocus();
                          // Capture the widget as an image
                          _capturedImageBytes = await _controller.capture();
                          if (_capturedImageBytes != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Image Saved successfully in your Gallery!')),
                            );
                            _saveImage(_capturedImageBytes);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to capture image.')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error capturing image: $e')),
                          );
                        }
                      },
                      child: const Text("Generate Photo"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.blue,
                      ),

                    ),
                  ),
              ),
            ],
          ),
    );
  }
}