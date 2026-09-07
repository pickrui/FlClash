package com.oixcloud.clash

import java.util.Base64
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertThrows
import org.junit.Assert.assertTrue
import org.junit.Test

class ConfigKeyPolicyTest {
    private val secureSeed = Base64.getEncoder().encodeToString(ByteArray(32) { it.toByte() })
    private val legacySeed = Base64.getEncoder().encodeToString(ByteArray(32) { 42 })

    @Test
    fun acceptsOnlyCanonical32ByteSeeds() {
        assertTrue(isValidConfigSeed(secureSeed))
        assertTrue(isValidConfigSeed(legacySeed))
        for (size in listOf(0, 1, 16, 31, 33, 64)) {
            assertFalse(isValidConfigSeed(Base64.getEncoder().encodeToString(ByteArray(size))))
        }
        for (value in listOf(null, "", "not base64", secureSeed.trimEnd('='),
            "$secureSeed\n", " $secureSeed", "A".repeat(42) + "B=")) {
            assertFalse(isValidConfigSeed(value))
        }
    }

    @Test
    fun everyPossibleFinalByteMatchesTheCanonicalEncoding() {
        for (lastByte in 0..255) {
            val seed = ByteArray(32) { 0xff.toByte() }
            seed[31] = lastByte.toByte()
            assertTrue(isValidConfigSeed(Base64.getEncoder().encodeToString(seed)))
        }
    }

    @Test
    fun deletionMarkerPreventsAllKeyReads() = runBlocking {
        assertNull(readConfigSeed(
            isDeleted = { true },
            isMigrated = { error("must not inspect migrated state") },
            readLegacy = { error("must not inspect legacy seed") },
            readSecure = { error("must not initialize secure storage") },
        ))
    }

    @Test
    fun unmigratedLegacySeedHasSamePriorityAsDart() = runBlocking {
        assertEquals(legacySeed, readConfigSeed(
            isDeleted = { false },
            isMigrated = { false },
            readLegacy = { legacySeed },
            readSecure = { error("Dart uses the unmigrated legacy seed first") },
        ))
    }

    @Test
    fun migratedSecureSeedHasPriorityOverLegacy() = runBlocking {
        assertEquals(secureSeed, readConfigSeed(
            isDeleted = { false },
            isMigrated = { true },
            readLegacy = { legacySeed },
            readSecure = { secureSeed },
        ))
    }

    @Test
    fun readsSecureSeedWhenLegacyIsAbsentOrInvalid() = runBlocking {
        for (legacy in listOf(null, "invalid")) {
            assertEquals(secureSeed, readConfigSeed(
                isDeleted = { false },
                isMigrated = { false },
                readLegacy = { legacy },
                readSecure = { secureSeed },
            ))
        }
    }

    @Test
    fun invalidSecureSeedUsesValidLegacyWithoutCreatingASeed() = runBlocking {
        for (secure in listOf(null, "invalid")) {
            assertEquals(legacySeed, readConfigSeed(
                isDeleted = { false },
                isMigrated = { true },
                readLegacy = { legacySeed },
                readSecure = { secure },
            ))
            assertNull(readConfigSeed(
                isDeleted = { false },
                isMigrated = { true },
                readLegacy = { "invalid" },
                readSecure = { secure },
            ))
        }
    }

    @Test
    fun deletionDuringSecureReadDiscardsTheLoadedSeed() = runBlocking {
        var deleted = false
        assertNull(readConfigSeed(
            isDeleted = { deleted },
            isMigrated = { true },
            readLegacy = { legacySeed },
            readSecure = {
                deleted = true
                secureSeed
            },
        ))
    }

    @Test
    fun secureReadFailureIsNotTreatedAsAMissingKey() {
        val failure = IllegalStateException("KeyStore unavailable")
        val thrown = assertThrows(IllegalStateException::class.java) {
            runBlocking {
                readConfigSeed(
                    isDeleted = { false },
                    isMigrated = { true },
                    readLegacy = { legacySeed },
                    readSecure = { throw failure },
                )
            }
        }
        assertSame(failure, thrown)
    }
}
