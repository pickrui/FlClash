package com.oixcloud.clash

// A 32-byte value has 43 base64 digits followed by one padding character. The
// final digit has two zero padding bits. Matching this form also rejects the
// whitespace, missing padding and noncanonical padding bits rejected by Dart's
// ConfigKeyStore.decodeSeed, without requiring java.util.Base64 (API 26).
private val configSeedPattern = Regex("[A-Za-z0-9+/]{42}[AEIMQUYcgkosw048]=")

internal fun isValidConfigSeed(value: String?): Boolean =
    value != null && configSeedPattern.matches(value)

/** Read-only counterpart of SafeStorage.read for an existing config seed. */
internal suspend fun readConfigSeed(
    isDeleted: () -> Boolean,
    isMigrated: () -> Boolean,
    readLegacy: () -> String?,
    readSecure: suspend () -> String?,
): String? {
    if (isDeleted()) return null
    val legacy = readLegacy()?.takeIf(::isValidConfigSeed)
    val seed = if (!isMigrated() && legacy != null) {
        legacy
    } else {
        // Preserve read failures: a temporarily inaccessible key must not be
        // treated as missing or replaced with a different identity.
        readSecure()?.takeIf(::isValidConfigSeed) ?: legacy
    }
    return seed.takeUnless { isDeleted() }
}
