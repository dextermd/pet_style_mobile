part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<MessageEntity>? messages;

  const ChatLoadedState(this.messages);

  @override
  List<Object?> get props => [messages];
}

  

