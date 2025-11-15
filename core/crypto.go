package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/md5"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
)

// deriveKey derives AES key from device ID using SHA256
func deriveKey(deviceID string) []byte {
	hash := sha256.Sum256([]byte(deviceID + ":flclash:profile:key"))
	return hash[:]
}

// deriveIV derives IV from device ID using MD5
func deriveIV(deviceID string) []byte {
	hash := md5.Sum([]byte(deviceID + ":flclash:profile:iv"))
	return hash[:]
}

// decryptAES decrypts data using AES-256-CBC
func decryptAES(encryptedData []byte, deviceID string) ([]byte, error) {
	key := deriveKey(deviceID)
	iv := deriveIV(deviceID)

	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, fmt.Errorf("failed to create cipher: %w", err)
	}

	if len(encryptedData) < aes.BlockSize {
		return nil, fmt.Errorf("ciphertext too short")
	}

	if len(encryptedData)%aes.BlockSize != 0 {
		return nil, fmt.Errorf("ciphertext is not a multiple of the block size")
	}

	mode := cipher.NewCBCDecrypter(block, iv)
	decrypted := make([]byte, len(encryptedData))
	mode.CryptBlocks(decrypted, encryptedData)

	// Remove PKCS7 padding
	padding := int(decrypted[len(decrypted)-1])
	if padding > aes.BlockSize || padding == 0 {
		return decrypted, nil // No padding or invalid padding, return as is
	}

	for i := len(decrypted) - padding; i < len(decrypted); i++ {
		if decrypted[i] != byte(padding) {
			return decrypted, nil // Invalid padding, return as is
		}
	}

	return decrypted[:len(decrypted)-padding], nil
}

// hexToBytes converts hex string to bytes
func hexToBytes(hexStr string) ([]byte, error) {
	return hex.DecodeString(hexStr)
}
