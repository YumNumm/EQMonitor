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

// AGP 9 の lintVital が pub 依存の Android module (android_file_picker) で
// AndroidLintWorkAction を初期化できず release build ごと落ちるため無効化する。
// 対象は third-party の生成物で、lint 結果を我々が扱うことはない。
// NOTE: AGP 9 では lint DSL (checkReleaseBuilds) の設定が評価順の都合で
// "It is too late to set checkReleaseBuilds" になるため、タスク自体を無効化する。
subprojects {
    tasks.configureEach {
        if (name.startsWith("lintVital")) {
            enabled = false
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
