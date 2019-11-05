package v1

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/golang/protobuf/ptypes"
	"github.com/golang/protobuf/ptypes/empty"
	v1 "github.com/thevzurd/flutter-grpc-tutorial-master/go-server/pkg/api/v1"
)

// chatServiceServer is implementation of v1.ChatServiceServer proto interface
type chatServiceServer struct {
	chat chan v1.Chat
}

// NewChatServiceServer creates Chat service object
func NewChatServiceServer() v1.ChatServiceServer {
	return &chatServiceServer{chat: make(chan v1.Chat, 1000)}
}

// Send sends message to the server
func (s *chatServiceServer) Send(ctx context.Context, message *v1.Chat) (*empty.Empty, error) {
	if message != nil {
		log.Printf("Send requested: message=%v", *message)
		s.chat <- *message
	} else {
		log.Print("Send requested: message=<empty>")
	}

	return &empty.Empty{}, nil
}

// Subscribe is streaming method to get echo messages from the server
func (s *chatServiceServer) Subscribe(e *empty.Empty, stream v1.ChatService_SubscribeServer) error {
	log.Print("Subscribe requested")
	chatTimeStamp, _ := ptypes.TimestampProto(time.Now())
	for {
		m := <-s.chat
		n := v1.Chat{Text: fmt.Sprintf("I have received from you: %s. Thanks!", m.GetText()),
			Id:              chatTimeStamp.String(),
			Uid:             "B",
			CreatedAt:       chatTimeStamp,
			AttachmentType:  v1.Chat_NONE,
			AttachmentUrl:   "",
			ConversationsId: m.GetConversationsId()}
		if err := stream.Send(&n); err != nil {
			// put message back to the channel
			s.chat <- m
			log.Printf("Stream connection failed: %v", err)
			return nil
		}
		log.Printf("Message sent: %+v", n)
	}
}
