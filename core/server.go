//go:build !cgo

package main

import (
	"crypto/rand"
	"encoding/base64"
	"encoding/binary"
	"encoding/json"
	"errors"
	"io"
	"log"
	"net"
	"os"
	"strconv"
	"sync"
	"time"

	"golang.org/x/crypto/chacha20poly1305"
)

const maxIPCFrameLength = 64 * 1024 * 1024
const ipcReadyMessage = "flclash-ipc-ready-v1"

var (
	conn   net.Conn
	connMu sync.Mutex
)

// ipcKey is the per-session symmetric key for the local App<->core socket.
// It is delivered out-of-band via the FLCLASH_IPC_KEY environment variable at
// process launch, so it never traverses the socket itself. When unset the
// channel stays plaintext (backwards compatible).
var ipcKey []byte

func initIPCKey() {
	k := os.Getenv("FLCLASH_IPC_KEY")
	if k == "" {
		return
	}
	if raw, err := base64.StdEncoding.DecodeString(k); err == nil && len(raw) == chacha20poly1305.KeySize {
		ipcKey = raw
	}
}

// encodeFrame encrypts one frame payload: nonce || sealed.
func encodeFrame(plaintext []byte) ([]byte, error) {
	if ipcKey == nil {
		return plaintext, nil
	}
	aead, err := chacha20poly1305.New(ipcKey)
	if err != nil {
		return nil, err
	}
	nonce := make([]byte, chacha20poly1305.NonceSize)
	if _, err := rand.Read(nonce); err != nil {
		return nil, err
	}
	sealed := aead.Seal(nil, nonce, plaintext, nil)
	buf := make([]byte, 0, len(nonce)+len(sealed))
	buf = append(buf, nonce...)
	buf = append(buf, sealed...)
	return buf, nil
}

// decodeFrame reverses encodeFrame for one received frame payload.
func decodeFrame(raw []byte) ([]byte, error) {
	if ipcKey == nil {
		return raw, nil
	}
	if len(raw) < chacha20poly1305.NonceSize {
		return nil, errors.New("ipc frame too short")
	}
	aead, err := chacha20poly1305.New(ipcKey)
	if err != nil {
		return nil, err
	}
	nonce := raw[:chacha20poly1305.NonceSize]
	return aead.Open(nil, nonce, raw[chacha20poly1305.NonceSize:], nil)
}

func writeFrame(w io.Writer, data []byte) error {
	frame := make([]byte, 4+len(data))
	binary.LittleEndian.PutUint32(frame, uint32(len(data)))
	copy(frame[4:], data)
	_, err := w.Write(frame)
	return err
}

func readFrame(r io.Reader) ([]byte, error) {
	lenBuf := make([]byte, 4)
	if _, err := io.ReadFull(r, lenBuf); err != nil {
		return nil, err
	}
	length := binary.LittleEndian.Uint32(lenBuf)
	if length > maxIPCFrameLength {
		return nil, errors.New("ipc frame too large")
	}
	data := make([]byte, length)
	if _, err := io.ReadFull(r, data); err != nil {
		return nil, err
	}
	return data, nil
}

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
	frame, err := encodeFrame(data)
	if err != nil {
		return
	}
	connMu.Lock()
	defer connMu.Unlock()
	if err := writeFrame(conn, frame); err != nil {
		log.Println("server write error:", err)
	}
}

func startServer(arg string) {
	initIPCKey()

	network, address := "unix", arg
	if _, err := strconv.Atoi(arg); err == nil {
		network, address = "tcp", "127.0.0.1:"+arg
	}

	var dialErr error
	for i := 0; i < 5; i++ {
		if conn, dialErr = net.Dial(network, address); dialErr == nil {
			break
		}
		time.Sleep(time.Second)
	}
	if dialErr != nil {
		log.Println("Connection failed:", dialErr)
		return
	}
	defer func() {
		_ = conn.Close()
	}()
	readyFrame, err := encodeFrame([]byte(ipcReadyMessage))
	if err != nil {
		log.Println("IPC authentication failed:", err)
		return
	}
	if err := writeFrame(conn, readyFrame); err != nil {
		log.Println("IPC authentication write failed:", err)
		return
	}

	for {
		data, err := readFrame(conn)
		if err != nil {
			if err != io.EOF {
				log.Println("server read error:", err)
			}
			return
		}
		plain, err := decodeFrame(data)
		if err != nil {
			return
		}
		action := &Action{}
		if err := json.Unmarshal(plain, action); err != nil {
			return
		}
		go handleAction(action, ActionResult{
			Id:     action.Id,
			Method: action.Method,
		})
	}
}

func nextHandle(action *Action, result ActionResult) bool {
	return false
}
