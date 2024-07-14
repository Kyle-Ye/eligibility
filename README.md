# eligibility

This project is an open source reimplementation of eligibility related stuff.

> [!IMPORTANT]
> This project is under active, ongoing development and requires the latest beta
> version of macOS and Xcode.
>
> Currently it needs macOS 15 Beta 1 with Xcode 16 Beta 1

## Disclaimer

> [!CAUTION]
> Some feature will only work when SIP is disabled.
>
> Use at your own risk.

> [!NOTE]
> this project is for learning and research purposes only.
> 
> If you choose to use this project, you do so at your own risk and are responsible for compliance with any applicable laws.
>
> The author of this project is not responsible for any consequences that may arise from your use of this project.

## Status

### EligibilityCore

A SwiftPM C package to provide common header definitions for this project and can be used in other projects.

See detail on [EligibilityCore/README.md](EligibilityCore/README.md)

### eligibilityd

A binary to replace `/usr/libexec/eligibilityd`

See detail on [eligibilityd/README.md](eligibilityd/README.md)

### libsystem_eligibility

A library to replace `/usr/lib/system/libsystem_eligibility.dylib`

See detail on [libsystem_eligibility/README.md](libsystem_eligibility/README.md)

### eligibility_util

A Swift CLI tool to communite with eligibilityd with libsystem_eligibility API.

See detail on [eligibility_util/README.md](eligibility_util/README.md)

## Contributions

If you find any issues or have suggestions for improvements, feel free to submit an issue or a pull request.

## LICENSE

### EligbilityCore and eligibility_util

MIT license. See LICENSE file on each folder.

### eligibilityd and libsystem_eligibility

No license.
