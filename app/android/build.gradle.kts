allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Workaround: Flutter 3.44's built-in Kotlin (2.0.0) and KGP 2.2.21 declared
    // in settings.gradle.kts conflict in the build classpath, causing
    // extractXxxAnnotations to fail with "Could not generate a decorated class
    // for AndroidLintWorkAction". These tasks are only needed for AAR publishing,
    // not for app builds — but their output (typedefs.txt) is still wired as
    // input to LibraryAarJarsTask (syncXxxLibJars), so we can't simply disable
    // them. Instead, replace their actions with a no-op that touches the
    // declared output files, so downstream tasks see a valid empty input.
    //
    // afterEvaluate is registered BEFORE evaluationDependsOn so the hook is in
    // place before each subproject is forced to evaluate.
    afterEvaluate {
        tasks.matching { it.name.startsWith("extract") && it.name.endsWith("Annotations") }.configureEach {
            actions.clear()
            doLast {
                outputs.files.forEach { file ->
                    if (file.extension.isNotEmpty()) {
                        file.parentFile?.mkdirs()
                        if (!file.exists()) file.createNewFile()
                    } else {
                        file.mkdirs()
                    }
                }
            }
        }
    }

    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
