fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios certificates

```sh
[bundle exec] fastlane ios certificates
```

Download and install certificates and provisioning profiles for all configurations: development, AppStore and AdHoc

### ios setup_build_number

```sh
[bundle exec] fastlane ios setup_build_number
```

Increment the build number

### ios download_provisioning_profiles

```sh
[bundle exec] fastlane ios download_provisioning_profiles
```

Download the provisioning profiles

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Push a new beta build to TestFlight

### ios upload

```sh
[bundle exec] fastlane ios upload
```

Push a new build to App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
