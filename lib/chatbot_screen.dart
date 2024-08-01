import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'dart:io';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final Gemini _gemini = Gemini.instance;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        _messages.add({'sender': 'user', 'type': 'image', 'content': _image});
      });

      // Send the image to the chatbot
      _sendImageToChatBot(_image!);
    }
  }

  Future<void> _sendImageToChatBot(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final response = await _gemini.streamGenerateContent('image');
      response.listen((value) {
        setState(() {
          _messages.add({'sender': 'bot', 'type': 'text', 'content': value.output});
        });
      }).onError((e) {
        log('streamGenerateContent exception', error: e);
        setState(() {
          _messages.add({'sender': 'bot', 'type': 'text', 'content': 'Something went wrong. Please try again.'});
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'bot', 'type': 'text', 'content': 'Something went wrong. Please try again.'});
      });
    }
  }

  void _sendMessage(String message) {
    setState(() {
      _messages.add({'sender': 'user', 'type': 'text', 'content': message});
    });

    try {
      _gemini.streamGenerateContent(message).listen((value) {
        setState(() {
          _messages.add({'sender': 'bot', 'type': 'text', 'content': value.output});
        });
      }).onError((e) {
        log('streamGenerateContent exception', error: e);
        setState(() {
          _messages.add({'sender': 'bot', 'type': 'text', 'content': 'Something went wrong. Please try again.'});
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'bot', 'type': 'text', 'content': 'Something went wrong. Please try again.'});
      });
    }
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUser ? Colors.orangeAccent : Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isUser ? 'Siz' : 'All Götür',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isUser ? Colors.black : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            message['type'] == 'text'
                ? Text(
              message['content'],
              style: TextStyle(color: Colors.white),
            )
                : Image.file(message['content']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Götür ChatBot'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png', // Update with your image path
              height: 40, // Adjust height if needed
              width: 40, // Adjust width if needed
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.image, color: Colors.white),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
