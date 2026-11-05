package main

import (
	"context"
	"sync"
	"time"
)

// A probe without a caller-supplied budget still needs one.
const defaultDelayTestTimeout = 5 * time.Second

// delayTestTimeout converts the app's millisecond budget for one probe.
func delayTestTimeout(milliseconds int64) time.Duration {
	if milliseconds <= 0 {
		return defaultDelayTestTimeout
	}
	return time.Duration(milliseconds) * time.Millisecond
}

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

// message converts a background probe into a UI event. A health check applies
// its group's expected-status, so a measured delay alone does not mean the
// node is usable for that URL; only alive decides success here.
func (f *delayEventFilter) message(url, name string, value uint16, alive bool) *Delay {
	f.mu.Lock()
	active := f.active[delayTestTarget{name: name, url: url}] > 0
	f.mu.Unlock()
	if active {
		return nil
	}
	delay := int32(-1)
	if alive {
		delay = delayValue(value)
	}
	return &Delay{Url: url, Name: name, Value: delay}
}

// delayValue converts a successful probe's measurement, as upstream's
// delayValue does. It differs in one case: upstream reports a zero
// measurement as -1, but URLTest truncates sub-millisecond successes to zero,
// and both code bases sort 0 as "unknown" rather than failed
// (DelayStateExt.priority), so a fast success reports 1 instead of Timeout.
func delayValue(delay uint16) int32 {
	return max(int32(delay), 1)
}

// Manual probes carry the generation of the test run that started them. When a
// newer run begins, the probes still running belong to a result the app has
// already discarded, so they are cancelled instead of occupying the network,
// the probe semaphore and the app's request budget until their own deadline.
type delayProbeRegistry struct {
	mu      sync.Mutex
	highest int64
	lastID  int64
	active  map[int64]delayProbe
}

type delayProbe struct {
	generation int64
	cancel     context.CancelFunc
}

var manualDelayProbes delayProbeRegistry

// begin registers a probe and cancels every probe of an older generation. It
// returns the id that end takes.
func (r *delayProbeRegistry) begin(
	generation int64,
	cancel context.CancelFunc,
) int64 {
	r.mu.Lock()
	if generation > r.highest {
		r.highest = generation
	}
	var superseded []context.CancelFunc
	for id, probe := range r.active {
		// Generation zero is unscoped: no run owns it, so nothing supersedes it.
		if probe.generation > 0 && probe.generation < r.highest {
			superseded = append(superseded, probe.cancel)
			delete(r.active, id)
		}
	}
	r.lastID++
	id := r.lastID
	if r.active == nil {
		r.active = make(map[int64]delayProbe)
	}
	r.active[id] = delayProbe{generation: generation, cancel: cancel}
	r.mu.Unlock()
	for _, cancel := range superseded {
		cancel()
	}
	return id
}

func (r *delayProbeRegistry) end(id int64) {
	r.mu.Lock()
	delete(r.active, id)
	r.mu.Unlock()
}
