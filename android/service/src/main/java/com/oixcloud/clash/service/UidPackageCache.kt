package com.oixcloud.clash.service

import java.util.concurrent.ConcurrentHashMap

internal class UidPackageCache(private val lookup: (Int) -> Array<String>?) {
    @Volatile private var packages = ConcurrentHashMap<Int, String>()

    fun resolve(uid: Int): String {
        if (uid < 0) return ""
        val current = packages
        current[uid]?.let { return it }
        val name = lookup(uid)?.firstOrNull()?.takeIf { it.isNotEmpty() } ?: return ""
        return current.putIfAbsent(uid, name) ?: name
    }

    fun clear() {
        packages = ConcurrentHashMap()
    }
}
