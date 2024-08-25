# Etymo

Explore words like never before with definitions, origins, usage, and more in one powerful app.

## Development

Open `Etymo.xcodeproj` and build/run the project.

### Images

Convert all icons to [symbols](https://developer.apple.com/documentation/uikit/uiimage/creating_custom_symbol_images_for_your_app) and store them in `Assets.xcassets/Symbols`. Export symbols from [SF Symbols](https://developer.apple.com/sf-symbols/) or use [SF Symbol Creator](https://www.figma.com/community/plugin/1207724751253683840) to export custom icons from Figma.

Use compiled assets instead of string named images:

```
// Incorrect
Image("star")

// Correct
Image(.star)
```

### Device Support

Support is provided for the most current version and the previous version of iOS and iPadOS, as well as for earlier versions until their usage falls below 10%. For the latest statistics, see [iOS and iPadOS Usage](https://developer.apple.com/support/app-store/).

## Deployment

Update `TestFlight/WhatToTest.en-US.txt` with any instructions for testers.

Push to the `interview-submission` branch and the project will auto-deploy to [TestFlight](https://testflight.apple.com/join/9t9cTXZ2) using Xcode Cloud.

To release the app, use [App Store Connect](https://appstoreconnect.apple.com) to create a new version and submit it for Apple Review.

## Resources

- 🎨 [Figma Designs](https://www.figma.com/design/Edqid3ps1vdztSLTrzo5Fq/Etymo?node-id=0-1&t=Vs8GlF9mtC4CZoUX-1)
- 📖 [Merriam Webster Dictionary API](https://dictionaryapi.com/products/api-collegiate-dictionary)
- 📖 [Merriam Webster Documentation](https://dictionaryapi.com/products/json)
