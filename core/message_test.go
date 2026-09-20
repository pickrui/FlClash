package main

import (
	"encoding/json"
	"runtime"
	"testing"
	"testing/synctest"
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

func TestMessageBatcherStartsDeadlineWithFirstMessage(t *testing.T) {
	synctest.Test(t, func(t *testing.T) {
		queue := make(chan Message)
		batches := make(chan []Message, 2)
		done := make(chan struct{})
		go func() {
			defer close(done)
			runMessageBatcher(nil, queue, func(messages []Message) { batches <- messages })
		}()
		synctest.Wait()
		for round := 0; round < 2; round++ {
			time.Sleep(time.Hour + 5*time.Millisecond)
			queue <- Message{Type: LogMessage, Data: round}
			synctest.Wait()
			time.Sleep(messageBatchInterval - time.Nanosecond)
			synctest.Wait()
			select {
			case <-batches:
				t.Fatal("idle timer shortened a fresh batch deadline")
			default:
			}
			time.Sleep(time.Nanosecond)
			synctest.Wait()
			select {
			case batch := <-batches:
				if len(batch) != 1 || batch[0].Data != round {
					t.Fatal("unexpected batch")
				}
			default:
				t.Fatal("message was not delivered at its deadline")
			}
		}
		close(queue)
		<-done
	})
}

func TestMessageBatcherFlushesFullBatchThenPendingOnClose(t *testing.T) {
	synctest.Test(t, func(t *testing.T) {
		queue := make(chan Message, messageBatchSize)
		batches := make(chan []Message, 2)
		done := make(chan struct{})
		go func() {
			defer close(done)
			runMessageBatcher(nil, queue, func(messages []Message) { batches <- messages })
		}()
		for i := 0; i < messageBatchSize; i++ {
			queue <- Message{Type: LogMessage, Data: i}
		}
		synctest.Wait()
		select {
		case batch := <-batches:
			if len(batch) != messageBatchSize {
				t.Fatal("unexpected batch size")
			}
		default:
			t.Fatal("full batch waited for a timer")
		}
		time.Sleep(time.Hour)
		synctest.Wait()
		select {
		case <-batches:
			t.Fatal("idle batcher emitted a batch")
		default:
		}
		queue <- Message{Type: LogMessage, Data: messageBatchSize}
		close(queue)
		<-done
		select {
		case batch := <-batches:
			if len(batch) != 1 || batch[0].Data != messageBatchSize {
				t.Fatal("unexpected final batch")
			}
		default:
			t.Fatal("closing input lost the pending message")
		}
	})
}

func TestMessageBatcherPreservesStreamOrderAndBulkFairness(t *testing.T) {
	priority := make(chan Message, 100)
	bulk := make(chan Message, 20)
	for i := 0; i < 100; i++ {
		priority <- Message{Type: DelayMessage, Data: i}
	}
	for i := 0; i < 20; i++ {
		bulk <- Message{Type: LogMessage, Data: i}
	}
	close(priority)
	close(bulk)
	var highCount, bulkCount, delivered int
	runMessageBatcher(priority, bulk, func(messages []Message) {
		if len(messages) > messageBatchSize {
			t.Fatal("batch size limit exceeded")
		}
		for _, message := range messages {
			if message.Type == DelayMessage {
				if message.Data != highCount {
					t.Fatal("priority order changed")
				}
				highCount++
			} else {
				if bulkCount == 0 && delivered > messagePriorityBurst {
					t.Fatal("bulk messages starved")
				}
				if message.Data != bulkCount {
					t.Fatal("bulk order changed")
				}
				bulkCount++
			}
			delivered++
		}
	})
	if highCount != 100 || bulkCount != 20 {
		t.Fatal("messages lost")
	}
}
