import 'package:flutter/foundation.dart';

enum MessageSender { user, bot }

@immutable
class ChatMessage {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;

  final bool isError;

  ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    DateTime? timestamp,
    this.isError = false,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get isUser => sender == MessageSender.user;

  ChatMessage copyWith({String? text, bool? isError}) {
    return ChatMessage(
      id: id,
      text: text ?? this.text,
      sender: sender,
      timestamp: timestamp,
      isError: isError ?? this.isError,
    );
  }

  @override
  String toString() => 'ChatMessage(sender: $sender, text: $text)';
}
