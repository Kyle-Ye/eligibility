# EligibilityCore

This folder contains common header definitions for eligibility project.

EligibilityCore can be used as a SwiftPM package in other projects.

## Usage

```swift
dependencies: [
    .package(url: "https://github.com/Kyle-Ye/eligibility", from: "0.1.0"),
],
targets: [
    .target(
        ...
        dependencies: [
            .product(name: "EligibilityCore", package: "eligibility"),
            ...
        ],
    ),
    ...
]
```

## LICENSE

MIT license. See LICENSE file on this folder.
