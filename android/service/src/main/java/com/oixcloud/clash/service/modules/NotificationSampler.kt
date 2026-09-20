package com.oixcloud.clash.service.modules

import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.buffer
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.emptyFlow
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.map

@OptIn(ExperimentalCoroutinesApi::class)
internal fun <T : Any, R> notificationSamples(
    params: Flow<T?>,
    screenOn: Flow<Boolean>,
    ticks: () -> Flow<Unit>,
    sample: (T) -> R,
): Flow<R> = combine(params, screenOn) { value, visible ->
    if (visible) value else null
}.distinctUntilChanged().flatMapLatest { value ->
    if (value == null) emptyFlow() else ticks().map { sample(value) }.distinctUntilChanged()
}.buffer(0)
