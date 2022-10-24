import 'package:chateau_chat_gen/app.dart';
import 'package:chateau_chat_gen/screens/login_user_screen.dart';
import 'package:chateau_chat_gen/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  final client = StreamChatClient(streamapiKey);
  runApp(MyApp(
    cLient: client,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.cLient}) : super(key: key);

  final StreamChatClient cLient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return StreamChatCore(
          client: cLient,
          child: ChannelsBloc(
            child: UsersBloc(
              child: child!
            ),
          ),
        );
      },
      home: const SelectUserScreen(),
    );
  }
}
