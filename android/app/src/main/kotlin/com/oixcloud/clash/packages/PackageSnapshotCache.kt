package com.oixcloud.clash.packages

/** Invalidation never waits for PackageManager, and an old load cannot refill the cache. */
internal class PackageSnapshotCache<T>(private val load: () -> List<T>) {
    private val lock = Any()
    private var generation = Any()
    private var cached: List<T>? = null

    fun get(): List<T> {
        while (true) {
            val token = synchronized(lock) {
                cached?.let { return it }
                generation
            }
            val loaded = load().toList()
            synchronized(lock) {
                if (token === generation) {
                    return cached ?: loaded.also { cached = it }
                }
            }
        }
    }

    fun invalidate() = synchronized(lock) {
        generation = Any()
        cached = null
    }
}
