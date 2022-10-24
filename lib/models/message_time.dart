import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class MessageData {
  const MessageData({
    required this.senderName,
    required this.message,
    required this.messageDate,
    required this.dateMessage,
    required this.filePicture
  });
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String dateMessage;
  final CircleAvatar filePicture; 

}
