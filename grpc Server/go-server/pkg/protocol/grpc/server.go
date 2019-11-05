package grpc

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"

	v1 "github.com/thevzurd/flutter-grpc-tutorial-master/go-server/pkg/api/v1"
)

// RunServer registers gRPC service and run server
func RunServer(ctx context.Context, srv v1.ChatServiceServer, port string) error {
	listen, err := net.Listen("tcp", "localhost:"+port)
	if err != nil {
		return err
	}

	// register service
	server := grpc.NewServer()
	v1.RegisterChatServiceServer(server, srv)

	// start gRPC server
	log.Println("starting gRPC server... ", listen.Addr())
	return server.Serve(listen)
}
