package main

import (
	"time"

	"github.com/metacubex/mihomo/tunnel/statistic"
)

const (
	messageBatchInterval = 16 * time.Millisecond
	messageBatchSize     = 32
	messageQueueSize     = 256
	messagePriorityBurst = 8
)

var (
	priorityMessageQueue = make(chan Message, messageQueueSize)
	bulkMessageQueue     = make(chan Message, messageQueueSize)
)

func init() {
	go runMessageBatcher(priorityMessageQueue, bulkMessageQueue, sendMessageBatch)
}

// Request events need metadata and live counters, not the underlying connection.
func requestMessage(tracker statistic.Tracker) Message {
	return Message{Type: RequestMessage, Data: tracker.Info()}
}

func sendMessage(message Message) {
	queue := priorityMessageQueue
	if message.Type == LogMessage || message.Type == RequestMessage {
		queue = bulkMessageQueue
	}
	enqueueLatest(queue, message)
}

func enqueueLatest(queue chan Message, message Message) {
	select {
	case queue <- message:
		return
	default:
	}
	select {
	case <-queue:
	default:
	}
	select {
	case queue <- message:
	default:
	}
}

func runMessageBatcher(
	priorityMessages <-chan Message,
	bulkMessages <-chan Message,
	send func([]Message),
) {
	ticker := time.NewTicker(messageBatchInterval)
	defer ticker.Stop()
	batch := make([]Message, 0, messageBatchSize)
	flush := func() {
		if len(batch) == 0 {
			return
		}
		send(append([]Message(nil), batch...))
		// Reslicing alone keeps payloads reachable while the batcher is idle.
		clear(batch)
		batch = batch[:0]
	}
	appendMessage := func(message Message) {
		batch = append(batch, message)
		if len(batch) >= messageBatchSize {
			flush()
		}
	}
	priorityBurst := 0
	for priorityMessages != nil || bulkMessages != nil {
		if priorityBurst >= messagePriorityBurst && bulkMessages != nil {
			select {
			case message, ok := <-bulkMessages:
				if !ok {
					bulkMessages = nil
				} else {
					appendMessage(message)
				}
				priorityBurst = 0
				continue
			default:
				priorityBurst = 0
			}
		}
		select {
		case message, ok := <-priorityMessages:
			if !ok {
				priorityMessages = nil
			} else {
				appendMessage(message)
				priorityBurst++
			}
			continue
		default:
		}
		select {
		case message, ok := <-priorityMessages:
			if !ok {
				priorityMessages = nil
			} else {
				appendMessage(message)
				priorityBurst++
			}
		case message, ok := <-bulkMessages:
			if !ok {
				bulkMessages = nil
			} else {
				appendMessage(message)
			}
			priorityBurst = 0
		case <-ticker.C:
			flush()
		}
	}
	flush()
}
