package com.oixcloud.clash.service

import com.oixcloud.clash.service.modules.notificationSamples
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withTimeout
import kotlinx.coroutines.yield
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Test

class NotificationSamplerTest {
    private suspend fun settleUntil(condition: () -> Boolean) {
        withTimeout(3000) { while (!condition()) yield() }
    }

    @Test fun screenOffStopsTimerAndSamplingAndScreenOnImmediatelyRefreshes() = runBlocking {
        val params = MutableStateFlow<Int?>(1)
        val screen = MutableStateFlow(false)
        val ticks = Channel<Unit>()
        val updates = mutableListOf<Int>()
        var active = 0
        var starts = 0
        var samples = 0
        val job = launch {
            notificationSamples(params, screen, ticks = {
                flow {
                    active++
                    starts++
                    try {
                        emit(Unit)
                        for (tick in ticks) emit(tick)
                    } finally { active-- }
                }
            }, sample = { samples++; it }).collect { updates.add(it) }
        }
        repeat(20) { yield() }
        assertEquals(0, starts)
        screen.value = true
        settleUntil { updates.size == 1 }
        assertEquals(1, samples)
        ticks.send(Unit)
        settleUntil { samples == 2 }
        assertEquals(listOf(1), updates)
        screen.value = false
        settleUntil { active == 0 }
        assertFalse(ticks.trySend(Unit).isSuccess)
        params.value = 2
        repeat(20) { yield() }
        assertEquals(2, samples)
        screen.value = true
        settleUntil { updates.size == 2 }
        assertEquals(listOf(1, 2), updates)
        assertEquals(2, starts)
        job.cancelAndJoin()
        assertEquals(0, active)
    }

    @Test fun parameterRemovalStopsSamplingAndRestorationRefreshesUnchangedText() = runBlocking {
        val params = MutableStateFlow<Int?>(1)
        val screen = MutableStateFlow(true)
        val ticks = Channel<Unit>()
        val updates = mutableListOf<Int>()
        var active = 0
        val job = launch {
            notificationSamples(params, screen, ticks = {
                flow {
                    active++
                    try {
                        emit(Unit)
                        for (tick in ticks) emit(tick)
                    } finally { active-- }
                }
            }, sample = { it }).collect { updates.add(it) }
        }
        settleUntil { updates.size == 1 }
        params.value = null
        settleUntil { active == 0 }
        assertFalse(ticks.trySend(Unit).isSuccess)
        params.value = 1
        settleUntil { updates.size == 2 }
        assertEquals(listOf(1, 1), updates)
        job.cancelAndJoin()
        assertEquals(0, active)
    }
}
