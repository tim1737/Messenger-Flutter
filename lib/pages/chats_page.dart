import 'package:chateau_chat_gen/app.dart';
import 'package:chateau_chat_gen/theme.dart';
import 'package:chateau_chat_gen/widgets/alert_error_chat.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:jiffy/jiffy.dart';
import '../helpers.dart';
import '../screens/chat_screen.dart';
import '../widgets/avatar.dart';
import '../widgets/read_Indicate.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) {
    return ChannelListCore(
      channelListController: channelListController,
      filter: Filter.and([
        Filter.equal('type', 'messaging'),
        Filter.in_('members', [StreamChatCore.of(context).currentUser!.id])
      ]),
      emptyBuilder: (context) => const Center(
        child: Text(
          'Write to someone',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      errorBuilder: (context, error) => DisplayErrorMessage(
        error: error,
      ),
      loadingBuilder: (
        context,
      ) =>
          const Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        ),
      ),
      listBuilder: (context, channels) {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _ChatTitle(
                    channel: channels[index],
                  );
                },
                childCount: channels.length,
              ),
            )
          ],
        );
      },
    );
  }
}

class _ChatTitle extends StatelessWidget {
  const _ChatTitle({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
      },
      child: Expanded(
        child: Container(
          height: 90,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                    url:
                        Helpers.getChannelImage(channel, context.currentUser!)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        Helpers.getChannelName(channel, context.currentUser!),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w900,
                            fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 20,
                        child: _makeStreamMessage(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    _makeStreamMessageTime(),
                    const SizedBox(
                      height: 8,
                    ),
                   Center(child: UnreadIndicator(
                    channel: channel,
                   ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // last Message stream
  Widget _makeStreamMessage() {
    return BetterStreamBuilder<Message>(
        stream: channel.state!.lastMessageStream,
        initialData: channel.state!.lastMessage,
        builder: (context, lastMessage) {
          return Text(
            lastMessage.text ?? '',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textFaded,
            ),
          );
        });
  }

  // last Message stream time
  Widget _makeStreamMessageTime() {
    return BetterStreamBuilder<DateTime>(
      stream: channel.lastMessageAtStream,
      initialData: channel.lastMessageAt,
      builder: (context, data) {
        final lastMessageAt = data.toLocal();
        String stringDate;
        final now = DateTime.now();

        final startOfDay = DateTime(now.year, now.month, now.day);

        if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay.millisecondsSinceEpoch) {
          stringDate = Jiffy(lastMessageAt.toLocal()).jm;
        } else if (lastMessageAt.millisecondsSinceEpoch >=
            startOfDay
                .subtract(const Duration(days: 1))
                .millisecondsSinceEpoch) {
          stringDate = 'YESTERDAY';
        } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
          stringDate = Jiffy(lastMessageAt.toLocal()).EEEE;
        } else {
          stringDate = Jiffy(lastMessageAt.toLocal()).yMd;
        }
        return Text(
          stringDate,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: -0.2,
            fontWeight: FontWeight.w600,
            color: AppColors.textFaded,
          ),
        );
      },
    );
  }
}
