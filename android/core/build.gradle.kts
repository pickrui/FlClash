import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.oixcloud.clash.core"
    compileSdk = libs.versions.compileSdk.get().toInt()
    ndkVersion = libs.versions.ndkVersion.get()

    defaultConfig {
        minSdk = libs.versions.minSdk.get().toInt()
        // Match the Flutter build target so JNI never compiles against headers
        // for an architecture that setup.dart did not build.
        val flutterAbis = mapOf(
            "android-arm" to "armeabi-v7a",
            "android-arm64" to "arm64-v8a",
            "android-x64" to "x86_64"
        )
        val targets = providers.gradleProperty("target-platform")
            .orElse(flutterAbis.keys.joinToString(",")).get().split(",")
        ndk {
            abiFilters += targets.map { target ->
                requireNotNull(flutterAbis[target]) { "Unsupported Flutter target: $target" }
            }
        }
    }


    sourceSets {
        getByName("main") {
            jniLibs.srcDirs("src/main/jniLibs")
        }
    }

    externalNativeBuild {
        cmake {
            path("src/main/cpp/CMakeLists.txt")
            version = "3.22.1"
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

kotlin {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
    }
}


dependencies {
    implementation(libs.annotation.jvm)
}

// Native consumers need the hook outputs before CMake configures or JNI merges.
// mustRunAfter avoids introducing a cycle through the app Flutter build task.
val nativeTaskPattern =
    Regex("^(configureCMake|buildCMake|externalNativeBuild|merge.*(NativeLibs|JniLibFolders)|copy.*JniLibs)")
val flutterCompileTasks =
    rootProject.project(":app").tasks.matching { it.name.startsWith("compileFlutterBuild") }

tasks.matching { nativeTaskPattern.containsMatchIn(it.name) }.configureEach {
    mustRunAfter(flutterCompileTasks)
}

gradle.taskGraph.whenReady {
    val nativeTask =
        allTasks.firstOrNull {
            it.path.startsWith("${project.path}:") && nativeTaskPattern.containsMatchIn(it.name)
        }
    if (nativeTask == null || allTasks.any { it.path.startsWith(":app:compileFlutterBuild") }) {
        return@whenReady
    }
    val missing =
        android.defaultConfig.ndk.abiFilters
            .flatMap {
                listOf(file("src/main/jniLibs/$it/libclash.so"), file("src/main/cpp/includes/$it/libclash.h"))
            }.filterNot { it.isFile }
    if (missing.isNotEmpty()) {
        throw GradleException(
            "${nativeTask.name} consumes Core artifacts that the setup build hook writes into src/main, " +
                "and these are absent: ${missing.joinToString { it.relativeTo(projectDir).path }}. " +
                "Run `dart setup.dart android` once, or build through :app so the hook runs first.",
        )
    }
    logger.warn(
        ":core: ${nativeTask.name} is running without an :app Flutter compile task, " +
            "so the Core artifacts under src/main are whatever the last hook run left behind",
    )
}
