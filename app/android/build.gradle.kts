import com.android.build.api.dsl.ApplicationExtension
import com.android.build.api.dsl.LibraryExtension

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
subprojects {
    plugins.withId("com.android.application") {
        extensions.configure<ApplicationExtension>("android") {
            lint {
                checkReleaseBuilds = false
            }
        }
    }
    plugins.withId("com.android.library") {
        extensions.configure<LibraryExtension>("android") {
            lint {
                checkReleaseBuilds = false
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
