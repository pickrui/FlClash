//go:build !cgo

package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"net"
	"strconv"
	"time"
)

var conn net.Conn

func (result ActionResult) send() {
	data, err := result.Json()
	if err != nil {
		return
	}
	send(data)
}

func sendMessage(message Message) {
	result := ActionResult{
		Method: messageMethod,
		Data:   message,
	}
	result.send()
}

func send(data []byte) {
	if conn == nil {
		return
	}
	_, _ = conn.Write(append(data, []byte("\n")...))
}

func startServer(arg string) {

	_, err := strconv.Atoi(arg)

	var dialErr error
	for i := 0; i < 5; i++ {
		if err != nil {
			conn, dialErr = net.Dial("unix", arg)
		} else {
			conn, dialErr = net.Dial("tcp", fmt.Sprintf("127.0.0.1:%s", arg))
		}
		if dialErr == nil {
			break
		}
		time.Sleep(time.Second)
	}

	if dialErr != nil {
		log.Println("Connection failed:", dialErr)
		return
	}

	defer func(conn net.Conn) {
		_ = conn.Close()
	}(conn)

	reader := bufio.NewReader(conn)

	for {
		data, err := reader.ReadString('\n')
		if err != nil {
			return
		}
		var action = &Action{}

		err = json.Unmarshal([]byte(data), action)

		if err != nil {
			return
		}

		result := ActionResult{
			Id:     action.Id,
			Method: action.Method,
		}

		go handleAction(action, result)
	}
}

func nextHandle(action *Action, result ActionResult) bool {
	return false
}
