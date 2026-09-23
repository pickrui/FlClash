package com.oixcloud.clash.service

import android.database.Cursor
import android.database.MatrixCursor
import android.os.CancellationSignal
import android.os.ParcelFileDescriptor
import android.provider.DocumentsContract
import android.provider.DocumentsProvider
import java.io.File
import java.io.FileNotFoundException

class FilesProvider : DocumentsProvider() {

    companion object {
        private const val DEFAULT_ROOT_ID = "0"
        private const val ROOT_DOCUMENT_ID = "/"
        private const val ROOT_DISPLAY_NAME = "FlClash"

        private val DEFAULT_DOCUMENT_COLUMNS = arrayOf(
            DocumentsContract.Document.COLUMN_DOCUMENT_ID,
            DocumentsContract.Document.COLUMN_DISPLAY_NAME,
            DocumentsContract.Document.COLUMN_MIME_TYPE,
            DocumentsContract.Document.COLUMN_FLAGS,
            DocumentsContract.Document.COLUMN_SIZE,
        )
        private val DEFAULT_ROOT_COLUMNS = arrayOf(
            DocumentsContract.Root.COLUMN_ROOT_ID,
            DocumentsContract.Root.COLUMN_FLAGS,
            DocumentsContract.Root.COLUMN_ICON,
            DocumentsContract.Root.COLUMN_TITLE,
            DocumentsContract.Root.COLUMN_SUMMARY,
            DocumentsContract.Root.COLUMN_DOCUMENT_ID
        )
    }

    override fun onCreate(): Boolean {
        return true
    }

    override fun queryRoots(projection: Array<String>?): Cursor {
        return MatrixCursor(projection ?: DEFAULT_ROOT_COLUMNS).apply {
            newRow().apply {
                add(DocumentsContract.Root.COLUMN_ROOT_ID, DEFAULT_ROOT_ID)
                add(DocumentsContract.Root.COLUMN_FLAGS, DocumentsContract.Root.FLAG_LOCAL_ONLY)
                add(DocumentsContract.Root.COLUMN_ICON, R.drawable.ic_service)
                add(DocumentsContract.Root.COLUMN_TITLE, ROOT_DISPLAY_NAME)
                add(DocumentsContract.Root.COLUMN_SUMMARY, "Data")
                add(DocumentsContract.Root.COLUMN_DOCUMENT_ID, ROOT_DOCUMENT_ID)
            }
        }
    }


    override fun queryChildDocuments(
        parentDocumentId: String,
        projection: Array<String>?,
        sortOrder: String?
    ): Cursor {
        val result = MatrixCursor(resolveDocumentProjection(projection))
        val parentFile = resolveFile(parentDocumentId)
        parentFile.listFiles()?.forEach { file ->
            includeFile(result, file)
        }
        return result
    }

    override fun queryDocument(documentId: String, projection: Array<String>?): Cursor {
        val result = MatrixCursor(resolveDocumentProjection(projection))
        val file = resolveFile(documentId)
        if (documentId == ROOT_DOCUMENT_ID) {
            includeFile(result, file, ROOT_DOCUMENT_ID, ROOT_DISPLAY_NAME)
        } else {
            includeFile(result, file)
        }
        return result
    }

    override fun openDocument(
        documentId: String,
        mode: String,
        signal: CancellationSignal?
    ): ParcelFileDescriptor {
        val file = resolveFile(documentId)
        val accessMode = ParcelFileDescriptor.parseMode(mode)
        return ParcelFileDescriptor.open(file, accessMode)
    }

    private fun resolveFile(documentId: String): File {
        if (documentId != ROOT_DOCUMENT_ID) return File(documentId)
        return context?.filesDir ?: throw FileNotFoundException("Root directory not found")
    }

    private fun includeFile(
        result: MatrixCursor,
        file: File,
        documentId: String = file.absolutePath,
        displayName: String = file.name,
    ) {
        result.newRow().apply {
            add(DocumentsContract.Document.COLUMN_DOCUMENT_ID, documentId)
            add(DocumentsContract.Document.COLUMN_DISPLAY_NAME, displayName)
            add(DocumentsContract.Document.COLUMN_SIZE, file.length())
            add(
                DocumentsContract.Document.COLUMN_FLAGS,
                if (file.isDirectory) 0 else DocumentsContract.Document.FLAG_SUPPORTS_WRITE
            )
            add(DocumentsContract.Document.COLUMN_MIME_TYPE, getDocumentType(file))
        }
    }

    private fun getDocumentType(file: File): String {
        return if (file.isDirectory) {
            DocumentsContract.Document.MIME_TYPE_DIR
        } else {
            "application/octet-stream"
        }
    }

    private fun resolveDocumentProjection(projection: Array<String>?): Array<String> {
        return projection ?: DEFAULT_DOCUMENT_COLUMNS
    }
}