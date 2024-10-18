import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_style_mobile/blocs/chat/chat_bloc.dart';
import 'package:pet_style_mobile/blocs/user/user_bloc.dart';
import 'package:pet_style_mobile/core/services/storage_services.dart';
import 'package:pet_style_mobile/core/theme/colors.dart';
import 'package:pet_style_mobile/core/values/constants.dart';
import 'package:pet_style_mobile/src/domain/entity/chat_message/message_entity.dart';
import 'package:pet_style_mobile/src/view/app/chat/widgets/chat_bubble.dart';
import 'package:pet_style_mobile/src/view/widget/my_text_field.dart';


class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? senderId;

  const ChatScreen({
    super.key,
    this.receiverId,
    this.senderId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String? localSenderId = GetIt.I<StorageServices>().getString(AppConstants.STORAGE_USER_ID);

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ConnectToSocketEvent(
        senderId: widget.senderId ?? localSenderId ?? '',
        receiverId: widget.receiverId ?? '1'));
    context
        .read<UserBloc>()
        .add(GetSenderUserEvent(senderId: widget.receiverId ?? '1'));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            toolbarHeight: 50,
            leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.whiteText,
                size: 26,
              ),
            ),
            title: const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                ),
                SizedBox(width: 10),
                Text(
                  'Имя пользователя',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.whiteText,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.primarySecondElement,
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatLoadedState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom();
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is ChatLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ChatLoadedState &&
                        state.messages!.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.messages!.length,
                          itemBuilder: (context, index) {
                            final message = state.messages![index];
                            final isCurrentUser = message.senderId ==
                                (widget.senderId ?? localSenderId);

                            if (!isCurrentUser && message.status == 1) {
                              context
                                  .read<ChatBloc>()
                                  .add(UpdateStatusToReadEvent(message.id!, 2));
                            }
                            return ListTile(
                              title: Column(
                                children: [
                                  Container(
                                    alignment: isCurrentUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: ChatBubble(
                                      message: message.text ?? '',
                                      isCurrentUser: isCurrentUser,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: isCurrentUser
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${message.createdAt!.hour}:${message.createdAt!.minute}',
                                          style: const TextStyle(
                                            color: AppColors.primarySecondText,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        if (isCurrentUser)
                                          buildMessageStatus(
                                              message.status!, message),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Нет сообщений'),
                      );
                    }
                  },
                ),
              ),
              Container(
                color: AppColors.primaryTransparent,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15),
                        child: MyTextField(
                          contentPadding: 14,
                          controller: _messageController,
                          hintText: 'Введите сообщение',
                          obscureText: false,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final message = MessageEntity(
                          text: _messageController.text,
                          senderId: widget.senderId ?? localSenderId,
                          receiverId: widget.receiverId ?? '1',
                          createdAt: DateTime.now(),
                          status: 0,
                        );
                        context.read<ChatBloc>().add(SendMessageEvent(message));
                        _messageController.clear();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMessageStatus(int status, MessageEntity message) {
    switch (status) {
      case 0: // sending
        return const SizedBox(
          width: 10,
          height: 10,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        );
      case 1: // sent
        return const Icon(Icons.check, color: Colors.blue);
      case 2: // read
        return const Icon(Icons.done_all, color: Colors.blue);
      case 3: // failed
        return IconButton(
          icon: const Icon(Icons.refresh, color: Colors.red),
          onPressed: () {
            final failedMessage = message.copyWith(status: 0);
            context.read<ChatBloc>().add(SendMessageEvent(failedMessage));
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
