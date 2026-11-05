//go:build !cgo

package main

import (
	"encoding/binary"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"sync"
)

var (
	conn   io.ReadWriteCloser
	connMu sync.Mutex
)

const maxIPCFrameSize = 64 * 1024 * 1024

func (response MethodResponse) send() {
	data, err := response.JSON()
	if err != nil {
		log.Printf("MethodResponse marshal error: id=%s err=%v", response.ID, err)
		return
	}
	send(data)
}

func sendMessageBatch(messages []Message) {
	arguments, err := json.Marshal(messages)
	if err != nil {
		log.Printf("Message batch marshal error: %v", err)
		return
	}
	call := MethodCall{Method: messageMethod, Arguments: arguments}
	data, err := json.Marshal(call)
	if err != nil {
		log.Printf("MethodCall marshal error: method=%s err=%v", call.Method, err)
		return
	}
	send(data)
}

func writeFrame(writer io.Writer, data []byte) error {
	if len(data) > maxIPCFrameSize {
		return fmt.Errorf("IPC frame exceeds %d bytes", maxIPCFrameSize)
	}
	header := [4]byte{}
	binary.LittleEndian.PutUint32(header[:], uint32(len(data)))
	if err := writeAll(writer, header[:]); err != nil {
		return err
	}
	return writeAll(writer, data)
}

func writeAll(writer io.Writer, data []byte) error {
	for len(data) > 0 {
		written, err := writer.Write(data)
		if err != nil {
			return err
		}
		if written == 0 {
			return io.ErrShortWrite
		}
		data = data[written:]
	}
	return nil
}

func readFrame(reader io.Reader) ([]byte, error) {
	header := make([]byte, 4)
	if _, err := io.ReadFull(reader, header); err != nil {
		return nil, err
	}
	length := binary.LittleEndian.Uint32(header)
	if length > maxIPCFrameSize {
		return nil, fmt.Errorf("IPC frame exceeds %d bytes", maxIPCFrameSize)
	}
	data := make([]byte, int(length))
	if _, err := io.ReadFull(reader, data); err != nil {
		return nil, err
	}
	return data, nil
}

func send(data []byte) {
	if conn == nil {
		log.Printf("send conn nil")
		return
	}
	connMu.Lock()
	defer connMu.Unlock()
	if err := writeFrame(conn, data); err != nil {
		log.Printf("server write error: %v", err)
	}
}

func startServer(address string) {
	var err error
	conn, err = dial(address)
	if err != nil {
		panic(err.Error())
	}
	defer func() {
		_ = conn.Close()
	}()
	for {
		data, err := readFrame(conn)
		if err != nil {
			if err != io.EOF {
				log.Printf("server read error: %v", err)
			}
			return
		}
		call := &MethodCall{}
		if err := json.Unmarshal(data, call); err != nil {
			log.Printf("server unmarshal error: %v", err)
			continue
		}
		go handleMethodCall(call, MethodResponse{ID: call.ID})
	}
}
