package main

import (
	"context"
	"fmt"
	"os"

	grpc "github.com/thevzurd/flutter-grpc-tutorial-master/go-server/pkg/protocol/grpc"
	v1 "github.com/thevzurd/flutter-grpc-tutorial-master/go-server/pkg/service/v1"
)

func main() {
	if err := grpc.RunServer(context.Background(), v1.NewChatServiceServer(), "3000"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
