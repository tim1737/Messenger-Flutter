import 'package:flutter/material.dart';

const users = [
  userArtem,
  userDanil,
  userMiku,
];

const userArtem = DemoUser(
  id: 'artem',
  name: 'Artem DarkHolme',
  image:
      'https://wonder-day.com/wp-content/uploads/2022/03/wonder-day-avatar-memes-cats-35.jpg',
);

const userDanil = DemoUser(
  id: 'danil',
  name: 'Danil Nocringeman',
  image:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-EGJLyd6WUjZwGRu_PHNkRzh_Fl7EgaIXWw&usqp=CAU',
);

const userMiku = DemoUser(
  id: 'miku',
  name: 'Miku Runovskiy',
  image:
      'https://abrakadabra.fun/uploads/posts/2022-01/1643037201_2-abrakadabra-fun-p-miku-na-avu-6.jpg',
);






@immutable
class DemoUser {
  final String id;
  final String name;
  final String image;

  const DemoUser({
    required this.id,
    required this.name,
    required this.image,
  });
}