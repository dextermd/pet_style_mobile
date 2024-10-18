import 'package:get_it/get_it.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/data/model/auth_response/auth_response.dart';
import 'package:pet_style_mobile/src/domain/entity/chat_message/message_entity.dart';
import 'package:pet_style_mobile/src/domain/repository/auth_repository.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final AuthRepository _authRepository = GetIt.I<AuthRepository>();
  final StorageServices _storageServices = GetIt.I<StorageServices>();
  late String? token = '';
  bool isConnected = false;

  void connect(String userId, String token) async {
    if (isConnected) {
      logDebug('Socket already connected, skipping new connection.');
      return;
    }
    socket = IO.io(
        'http://localhost:3002',
        IO.OptionBuilder().setTransports(['websocket']).setQuery({
          'userId': userId,
          'token': token,
        }).build());

    socket.connect();

    socket.onConnect((_) {
      logDebug('Socket connected');
      isConnected = true;
    });

    socket.onConnectError((error) {
      logDebug('Connection error: $error');
    });

    socket.onReconnect((_) {
      logDebug('Socket reconnected');
    });

    socket.onReconnectError((error) {
      logDebug('Reconnect error: $error');
    });

    socket.onReconnectFailed((_) {
      logDebug('Reconnect failed');
    });

    socket.onDisconnect((_) {
      logDebug('Socket disconnected');
      isConnected = false;
    });
  }

  sendMessage(MessageEntity message) async {
    socket.emit('msgToServer', message.toJson());
  }

  updateMessageStatus(String messageId, int status) {
    socket.emit('updateMessageStatus', {
      'messageId': messageId,
      'status': status,
    });
  }

  Future<void> refreshTokenAndReconnect(String userId) async {
    try {
      final refreshToken =
          _storageServices.getString(AppConstants.STORAGE_REFRESH_TOKEN);
      final AuthResponse? newTokens =
          await _authRepository.refreshToken(refreshToken ?? '');
      if (newTokens != null) {
        disconnect();
        token = newTokens.accessToken;

        await Future.delayed(const Duration(seconds: 1));

        connect(userId, token!);

        logDebug('Reconnected with new token');
      } else {
        logDebug('Failed to refresh token');
      }
    } catch (e) {
      logDebug('Error refreshing token: $e');
    }
  }

  void disconnect() {
    if (isConnected) {
      socket.disconnect();
      logDebug('Socket disconnected');
    } else {
      logDebug('Socket is not connected, no need to disconnect.');
    }
  }
}
