import 'package:chateau_chat_gen/screens/profile_screen.dart';
import 'package:chateau_chat_gen/widgets/avatar.dart';
import 'package:chateau_chat_gen/widgets/icon_appbar.dart';
import 'package:flutter/material.dart';
import '../pages/contacts_page.dart';
import '../pages/chats_page.dart';
import '../pages/notif_page.dart';
import '../pages/settings_page.dart';
import '../theme.dart';
import '../app.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  final pages = const [
    ChatPage(),
    ContactsPage(),
    SettingsPage(),
    NotifPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "ttMess",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: IconBackground(
                icon: Icons.search,
                onTap: () {
                  // print("SEAARCH");
                },
              ),
            ),
          )
        ],
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Avatar.small(
                url: context.currentUserImage,
                onTap: () {
                  Navigator.of(context).push(ProfileScreen.route);
                },
              ),
            ),
            IconBackground(
              icon: Icons.notifications,
              onTap: () {
                pageIndex.value = 3;
              },
            )
          ],
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext conext, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: BotNavigationPanelWidget(
        ValueTap: (index) {
          pageIndex.value = index;
        },
      ),
    );
  }
}

class BotNavigationPanelWidget extends StatefulWidget {
  const BotNavigationPanelWidget({
    Key? key,
    required this.ValueTap,
  }) : super(key: key);

  final ValueChanged<int> ValueTap;

  @override
  State<BotNavigationPanelWidget> createState() =>
      _BotNavigationPanelWidgetState();
}

class _BotNavigationPanelWidgetState extends State<BotNavigationPanelWidget> {
  var chooseIndex = 0;

  void handleitem(int index) {
    setState(() {
      chooseIndex = index;
    });

    widget.ValueTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: GestureDetector(
          // onTap: () => changTap(index),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationPanelObj(
                index: 0,
                message: 'Chats',
                iconBar: Icons.messenger_outline,
                changTap: handleitem,
                isChoose: (chooseIndex == 0),
              ),
              _NavigationPanelObj(
                index: 1,
                message: 'Contacts',
                iconBar: Icons.contacts,
                changTap: handleitem,
                isChoose: (chooseIndex == 1),
              ),
              _NavigationPanelObj(
                index: 2,
                message: 'Settings',
                iconBar: Icons.settings,
                changTap: handleitem,
                isChoose: (chooseIndex == 2),
              ),
            ],
          ),
        ));
  }
}

class _NavigationPanelObj extends StatelessWidget {
  const _NavigationPanelObj(
      {Key? key,
      required this.index,
      required this.message,
      required this.iconBar,
      required this.changTap,
      this.isChoose = false})
      : super(key: key);

  final ValueChanged<int> changTap;

  final String message;

  final IconData iconBar;

  final int index;

  final bool isChoose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        changTap(index);
      },
      child: SizedBox(
        height: 74,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconBar,
              size: 27,
              color: isChoose ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              message,
              style: isChoose
                  ? const TextStyle(
                      fontSize: 12,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
