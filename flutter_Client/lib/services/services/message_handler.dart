/// Outgoing message statuses
/// NEW - message just created and is not sent yet
/// SENT - message is sent to the server successfully
/// FAILED - error has happened while sending message
enum MessageStatus { NEW, SENT, FAILED, RECIEVED }

/// Type of Outgoing Message
/// CHAT for Chats
/// USER for user updates etc
/// CONVERSATION for conversation updates etc
enum MessageType { CHAT, USER, CONVERSATION, ERROR }

/// MessageOutgoing is class defining outgoing message data (id and text) and status
class MessageHandler<T> {
  MessageHandler({
    this.message,
    this.messageType,
    this.status,
  });

  /// Outgoing message status
  MessageStatus status;

  /// Message model in grpc protobuff format
  final T message;

  /// Message Type
  final MessageType messageType;
}
