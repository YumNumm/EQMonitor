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
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Workaround: extractXxxAnnotations tasks are only needed for AAR publishing,
// not for app builds. With Flutter 3.44's built-in Kotlin, having KGP in the
// build classpath causes a classloader conflict that breaks these tasks.
subprojects {
    afterEvaluate {
        tasks.matching { it.name.startsWith("extract") && it.name.endsWith("Annotations") }.configureEach {
            enabled = false
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
