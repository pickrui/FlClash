package main

import (
	"encoding/json"
	"runtime"
	"testing"
	"time"
	"weak"

	"github.com/metacubex/mihomo/tunnel/statistic"
)

type messageTestTracker struct {
	statistic.Tracker `json:"-"`
	*statistic.TrackerInfo
	buffer [1024]byte
}

func (tracker *messageTestTracker) Info() *statistic.TrackerInfo { return tracker.TrackerInfo }

func TestRequestMessagePreservesJSONWithoutRetainingConnection(t *testing.T) {
	tracker := &messageTestTracker{TrackerInfo: &statistic.TrackerInfo{Rule: "MATCH"}}
	message := requestMessage(tracker)
	if message.Data != tracker.Info() {
		t.Fatal("request event retains more than connection information")
	}
	tracker.UploadTotal.Add(123)
	before, err := json.Marshal(Message{Type: RequestMessage, Data: tracker})
	if err != nil {
		t.Fatal(err)
	}
	after, err := json.Marshal(message)
	if err != nil {
		t.Fatal(err)
	}
	if string(before) != string(after) {
		t.Fatalf("request JSON changed: %s != %s", before, after)
	}
}

func TestMessageBatcherReleasesPayloadWhileIdle(t *testing.T) {
	queue := make(chan Message)
	flushed := make(chan struct{}, 1)
	done := make(chan struct{})
	go func() {
		defer close(done)
		runMessageBatcher(nil, queue, func(messages []Message) {
			if len(messages) != 1 {
				panic("unexpected message count")
			}
			flushed <- struct{}{}
		})
	}()
	defer func() { close(queue); <-done }()
	payload := new([1024 * 1024]byte)
	pointer := weak.Make(payload)
	queue <- Message{Type: LogMessage, Data: payload}
	payload = nil
	select {
	case <-flushed:
	case <-time.After(3 * time.Second):
		t.Fatal("message was not flushed")
	}
	deadline := time.Now().Add(3 * time.Second)
	for time.Now().Before(deadline) {
		runtime.GC()
		if pointer.Value() == nil {
			return
		}
		time.Sleep(10 * time.Millisecond)
	}
	t.Fatal("idle batcher retained the flushed payload")
}

func TestMessageBatcherKeepsDeliveredBatchIndependent(t *testing.T) {
	queue := make(chan Message, messageBatchSize+1)
	for i := 0; i < messageBatchSize+1; i++ {
		queue <- Message{Type: LogMessage, Data: i}
	}
	close(queue)
	var batches [][]Message
	runMessageBatcher(nil, queue, func(messages []Message) { batches = append(batches, messages) })
	var count int
	for _, batch := range batches {
		for _, message := range batch {
			if message.Type != LogMessage || message.Data != count {
				t.Fatalf("delivered message %d was changed: %#v", count, message)
			}
			count++
		}
	}
	if count != messageBatchSize+1 {
		t.Fatalf("delivered %d messages", count)
	}
}
