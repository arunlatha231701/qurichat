import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  void connect(String userId) {
    _socket = IO.io(
      'http://45.129.87.38:6065',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setQuery({'userId': userId})
          .build(),
    );

    _socket.onConnect((_) {
      print('Socket connected');
    });

    _socket.onDisconnect((_) => print('Socket disconnected'));
  }

  void sendMessage(Map<String, dynamic> message) {
    _socket.emit('send_message', message);
  }

  void listenForMessages(Function(dynamic) callback) {
    _socket.on('receive_message', callback);
  }

  void disconnect() {
    _socket.disconnect();
  }
}