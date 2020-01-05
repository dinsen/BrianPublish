---
date: 2020-01-05 12:39
description: In this post I will show how to create a new theme for Publish in it's own Swift Package.
tags: publish, Swift 5.1, swift package manager, theme 
---
# Create a Publish theme in it's own Swift Package

As promised [John Sundell](https://swiftbysundell.com/) released the last tool for his Swift based Static Site Generator, just before we said goodbye to 2019 👋

6 days later [Publish](https://github.com/johnsundell/publish) have been well received by the community. With more than 1200 stars on GitHub and we already got a new release (0.2.0) with some great improvements made by the community.
Since Publish is new, there is still a lot of questions on how to use this new cool tool.  
With this post I will show, how you can make your own theme for your new website.  

Let's fire up Xcode and start by creating a new Swift Package: `File > New > Swift Package...`  
If you are making an open source theme, I will suggest using PublishTheme in the name of your package.   
Just so other people can see this is a theme for Publish.  
In this post I will make `BrianPublishTheme` and define it as `brian`.

First step is to add Publish as a dependency. Open Package.swift and add Publish to dependencies:

```
// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BrianPublishTheme",
    products: [
        .library(
            name: "BrianPublishTheme",
            targets: ["BrianPublishTheme"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "BrianPublishTheme",
            dependencies: ["Publish"]),
    ]
)
```
*Remember also to add Publish as dependencies in the target.*    
  
  
To store your resources like images, css or what else you will need, we create a `Resources` folder. And  to keep the same structure as Publish, we create a folder named `BrianTheme` and copys the `styles.css` file from Publish into it. Now we have a starting point if you not already have your own  `.css` file.  

In `Sources/BrianPublishTheme` there is a swift file that was made when we created the package. Renamed it to `Theme+Brian.swift`, again to keep the same structure/naming as in Publish.
To get started quickly and to have something to play with, you can copy the code from `Sources/Publish/API/Theme+Foundation.swift` and modified it for your needs.
Remember to change the name of the variable and the `HTMLFactory` struct.

```
...
public extension Theme {
    static var brian: Self {
        Theme(
            htmlFactory: BrianHTMLFactory(),
            resourcePaths: ["Resources/BrianTheme/styles.css"]
        )
    }
}

private struct BrianHTMLFactory<Site: Website>: HTMLFactory {
...
}
```
  
  
Now let's implement this new theme package to our website.
Open your project or create a new project by following the [Quick start](https://github.com/JohnSundell/Publish#quick-start) guide. In `Package.swift` we will add the new theme package as a local dependency, so it's easy to make changes to the theme without having to make a release every time you adjust a font size or a text color:
 
```
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish", from: "0.2.0"),
        .package(path: "../BrianPublishTheme")
    ],
    targets: [
        .target(
            name: "Brian",
            dependencies: ["Publish",
                           "BrianPublishTheme"]
        )
    ]
)
```

Last step is to start using the new theme. In the  `main.swift` file we need to import the theme package:
```
import BrianPublishTheme
```
And now we can use it by defining it like:
```
try Brian().publish(withTheme: .brian)
```
You can find both the [BrianPublishTheme](https://github.com/Dinsen/BrianPublishTheme) and the [Brian](https://github.com/Dinsen/BrianPublish) Publish project on GitHub.  

Okay, so this was my debut as a writer and I hope you could use this post. If you have any feedback on how I can improve writing, then please let me know. You can find me on [Twitter](https://twitter.com/briandinsen)

Thanks for reading 🙏
