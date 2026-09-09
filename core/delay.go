package main

import "sync"

type delayTestTarget struct {
	name string
	url  string
}

// Manual probes return their result over RPC. Their URLTest hook must not also
// publish an unscoped event that can overwrite a newer test or an in-flight retry.
// A count keeps suppression active when the same target is tested concurrently.
type delayEventFilter struct {
	mu     sync.Mutex
	active map[delayTestTarget]int
}

var manualDelayEvents delayEventFilter

func (f *delayEventFilter) begin(name, url string) func() {
	target := delayTestTarget{name: name, url: url}
	f.mu.Lock()
	if f.active == nil {
		f.active = make(map[delayTestTarget]int)
	}
	f.active[target]++
	f.mu.Unlock()
	return func() {
		f.mu.Lock()
		defer f.mu.Unlock()
		if f.active[target] == 1 {
			delete(f.active, target)
		} else {
			f.active[target]--
		}
	}
}

func (f *delayEventFilter) message(url, name string, value uint16) *Delay {
	f.mu.Lock()
	active := f.active[delayTestTarget{name: name, url: url}] > 0
	f.mu.Unlock()
	if active {
		return nil
	}
	delay := int32(value)
	if value == 0 {
		delay = -1
	}
	return &Delay{Url: url, Name: name, Value: delay}
}
