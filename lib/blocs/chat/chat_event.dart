// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ConnectToSocketEvent extends ChatEvent {
  final String senderId;
  final String receiverId;
  const ConnectToSocketEvent({
    required this.senderId,
    required this.receiverId,
  });

  @override
  List<Object> get props => [senderId];
}

class SendMessageEvent extends ChatEvent {
  final MessageEntity message;

  const SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

class GetChatMessagesEvent extends ChatEvent {
  final String receiverId;
  final String senderId;

  const GetChatMessagesEvent(this.receiverId, this.senderId);

  @override
  List<Object> get props => [receiverId, senderId];
}

class ReceiveMessageEvent extends ChatEvent {
  final MessageEntity message;

  const ReceiveMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateMessageStatusEvent extends ChatEvent {
  final String messageId;
  final int status;

  const UpdateMessageStatusEvent(this.messageId, this.status);

  @override
  List<Object> get props => [messageId, status];
}

class UpdateMessageWithIdEvent extends ChatEvent {
  final String oldId;
  final String newId;
  final int status;

  const UpdateMessageWithIdEvent(this.oldId, this.newId, this.status);

  @override
  List<Object> get props => [oldId, newId, status];
}

class UpdateStatusToReadEvent extends ChatEvent {
  final String messageId;
  final int status;

  const UpdateStatusToReadEvent(this.messageId, this.status);

  @override
  List<Object> get props => [messageId, status];
}
