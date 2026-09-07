package com.oixcloud.clash.service.modules

interface ModuleLoaderScope {
    fun <T : Module> install(module: T): T
}

interface ModuleLoader {
    fun load()

    fun cancel()
}

/** Keep startup and rollback synchronous with the service lifecycle. */
fun moduleLoader(block: ModuleLoaderScope.() -> Unit): ModuleLoader {
    val lock = Any()
    val modules = mutableListOf<Module>()

    return object : ModuleLoader {
        override fun load() = synchronized(lock) {
            if (modules.isNotEmpty()) return
            val scope = object : ModuleLoaderScope {
                override fun <T : Module> install(module: T): T {
                    // Include a partially initialized module in rollback.
                    modules.add(module)
                    module.install()
                    return module
                }
            }
            scope.block()
        }

        override fun cancel(): Unit = synchronized(lock) {
            var failure: Exception? = null
            for (module in modules.asReversed()) {
                try {
                    module.uninstall()
                } catch (error: Exception) {
                    if (failure == null) failure = error
                    else if (failure !== error) failure.addSuppressed(error)
                }
            }
            modules.clear()
            failure?.let { throw it }
        }
    }
}
