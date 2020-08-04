// swift-tools-version:5.1

import PackageDescription

/// The name of the entire package
let name = "TABTestKit"

/// The platforms this package supports
let supportedPlatforms: [SupportedPlatform] = [.iOS(.v12)]

/// The biometrics target contains the code for interacting with biometrics in simulators, which is Objective-C
let biometricsTarget: Target = .target(name: "Biometrics", path: "TABTestKit/Classes/Biometrics/")

/// The main TTK target. this has a dependency on the biometrics target. Having two targets means we can have a mixed-language package, which is otherwise not supported.
let mainTarget: Target = .target(name: name, dependencies: [.target(name: biometricsTarget.name)], path: "TABTestKit/Classes/", exclude: ["Biometrics/"])

/// The final product, using all of the above.
let product: Product = .library(name: name, type: .dynamic, targets: [mainTarget.name])

let package = Package(
    name: name,
    platforms: supportedPlatforms,
    products: [product],
    targets: [biometricsTarget, mainTarget]
)
