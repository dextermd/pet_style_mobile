import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style_mobile/core/helpers/log_helper.dart';
import 'package:pet_style_mobile/core/services/socket_service.dart';
import 'package:pet_style_mobile/src/domain/entity/chat_message/message_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SocketService socketService;

  ChatBloc(this.socketService) : super(ChatInitial()) {
    on<ConnectToSocketEvent>((event, emit) {
      // String? token =
      //     StorageServices.getString(AppConstants.STORAGE_ACCESS_TOKEN);

      // socketService.connect(event.senderId, token!);

      // socketService.socket.off('receiveMessage');
      // socketService.socket.on('receiveMessage', (data) {
      //   final message = MessageEntity.fromJson(data);
      //   add(ReceiveMessageEvent(message));
      // });

      socketService.socket.off('token_expired');
      socketService.socket.on('token_expired', (data) {
        logDebug('Block Refresh Token');
        socketService.refreshTokenAndReconnect(event.senderId);
        return;
      });

      add(GetChatMessagesEvent(event.senderId, event.receiverId));
    });

    on<SendMessageEvent>((event, emit) async {
      final tempMessage = event.message.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      if (state is ChatLoadedState) {
        final currentMessages =
            List<MessageEntity>.from((state as ChatLoadedState).messages ?? []);
        currentMessages.add(tempMessage);
        emit(ChatLoadedState(currentMessages));
      } else {
        emit(ChatLoadedState([tempMessage]));
      }
      try {
        socketService.socket.off('messageSent');
        socketService.sendMessage(tempMessage);

        socketService.socket.on('messageSent', (data) {
          final oldMessageId = data['oldMessageId'];
          final newMessageId = data['newMessageId'];
          final status = data['status'];

          add(UpdateMessageWithIdEvent(oldMessageId, newMessageId, status));
        });
      } catch (e, st) {
        logHandle('Error sending message: $e', st);
        add(UpdateMessageStatusEvent(tempMessage.id!, 3));
      }
    });

    on<ReceiveMessageEvent>((event, emit) {
      if (state is ChatLoadedState) {
        final currentMessages =
            List<MessageEntity>.from((state as ChatLoadedState).messages ?? []);
        currentMessages.add(event.message);

        emit(ChatLoadedState(List<MessageEntity>.from(currentMessages)));
      }
    });

    on<GetChatMessagesEvent>((event, emit) async {
      emit(ChatLoadingState());

      socketService.socket.emit('getChatHistory', {
        'senderId': event.senderId,
        'receiverId': event.receiverId,
      });

      final completer = Completer<void>();

      void handleChatHistory(data) {
        List<MessageEntity> messages = (data as List)
            .map((message) => MessageEntity.fromJson(message))
            .toList();

        emit(ChatLoadedState(messages));

        completer.complete();
      }

      socketService.socket.on('chatHistory', handleChatHistory);

      await completer.future;

      socketService.socket.off('chatHistory', handleChatHistory);
    });

    on<UpdateMessageWithIdEvent>((event, emit) {
      if (state is ChatLoadedState) {
        final updatedMessages =
            (state as ChatLoadedState).messages?.map((message) {
          if (message.id == event.oldId) {
            return message.copyWith(id: event.newId, status: event.status);
          }
          return message;
        }).toList();

        emit(ChatLoadedState(updatedMessages));
      }
    });

    on<UpdateMessageStatusEvent>((event, emit) {
      if (state is ChatLoadedState) {
        final updatedMessages =
            (state as ChatLoadedState).messages?.map((message) {
          if (message.id == event.messageId) {
            return message.copyWith(status: event.status);
          }
          return message;
        }).toList();

        emit(ChatLoadedState(updatedMessages));
      }
    });

    on<UpdateStatusToReadEvent>((event, emit) {
      logDebug('UpdateStatusToReadEvent Id: ${event.messageId}');
      logDebug('UpdateStatusToReadEvent Status: ${event.status}');
      emit(ChatLoadedState((state as ChatLoadedState)
          .messages
          ?.map((message) => message.id == event.messageId
              ? message.copyWith(status: event.status)
              : message)
          .toList()));
    });
  }
}
