fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios build
```
fastlane ios build
```
Build app
### ios tests
```
fastlane ios tests
```
Run unit tests
### ios lint
```
fastlane ios lint
```
Lint code
### ios screenshots
```
fastlane ios screenshots
```
Generate new localized screenshots
### ios manage_signing
```
fastlane ios manage_signing
```
Manage signing abilities, including devices, certificates, and provisioning profiles

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
