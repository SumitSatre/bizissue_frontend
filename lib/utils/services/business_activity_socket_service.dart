import 'package:socket_io_client/socket_io_client.dart' as IO;

class BusinessActivitySocketService {
  static final BusinessActivitySocketService _instance = BusinessActivitySocketService._internal();
  late IO.Socket socket;

  factory BusinessActivitySocketService() {
    return _instance;
  }

  BusinessActivitySocketService._internal() {
    socket = IO.io(
      'https://bizissue-backend.onrender.com/issue/chat',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.connect();

    socket.onConnect((_) {
      print('connected to business activity');
    });
  }
}
