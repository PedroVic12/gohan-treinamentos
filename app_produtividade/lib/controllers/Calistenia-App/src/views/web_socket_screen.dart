import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PersonalIAScreen extends StatelessWidget {
  const PersonalIAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WebSocketScreen(
        channel: WebSocketChannel.connect(
      Uri.parse('ws://localhost:8000/ws'),
    ));
  }
}

class WebSocketScreen extends StatefulWidget {
  final WebSocketChannel channel;

  WebSocketScreen({required this.channel});

  @override
  _WebSocketScreenState createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send message'),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            widget.channel.sink.add(_controller.text);
          }
        },
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
