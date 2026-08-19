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

// pub 依存 module の lintVital は third-party の生成物で結果を扱うことがないため
// 無効化する (release build 時間の節約)。
// かつて CI で AndroidLintWorkAction が初期化できなかった根本原因は
// JDK 17.0.2 の cgroup v2 検出 NPE で、mise.toml の Temurin 更新で解消済み。
// extract*Annotations は下流 (syncReleaseLibJars) が typedefs.txt を要求するため
// 無効化してはならない。
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
