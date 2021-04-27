<p align="center">
<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/logo.png">
</p>

![Swift-version](https://img.shields.io/badge/swift-5.3%2B-orange)
![CocoaPods](https://img.shields.io/badge/pod-v1.0.1-red)
![License](https://img.shields.io/github/license/KaoruMuta/IGStoryButtonKit)

# Introduction
Have you ever seen UI like instagram story, haven't you?
Actually, features like instagram story have been implemented in many applications recently. 

In order to implement these features like instagram story or rich UI quickly, IGStoryButtonKit provides an easy-to-use button so called `IGStoryButton` with rich animation and multiple way inspired by instagram story.

# Usage and Example
## Display Type
IGStoryButton has four display types; `seen`, `unseen`, `status`, `none` as the part of `IGStoryButton.DisplayType`. (`status` has two type; one is set color as an argument, the other is set image as an argument.)
The appearance of IGStoryButton depends on these display types. 

## Color Type
Circle ring which surrounds IGStoryButton has four color types: `default`, `black`, `clear`, `custom` as the part of `IGStoryButton.ColorType`.

||default|black|clear|custom(colors:)|
|----|----|----|----|----|
|actual value|`[UIColor.systemPink, UIColor.orange]`|`[UIColor.black, UIColor.lightGray]`|`[UIColor.clear]`|value set in argument|

## Appearance by specific display and color types
The detail is as follows. Once you only set DisplayType, color of outside circle ring is automatically set as default color for the first time.

||seen|unseen|status(color:)|status(image:)|none|
|----|----|----|----|----|----|
|appearance|<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/DisplayType.seen.png">|<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/DisplayType.unseen.png">|<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/DisplayType.status.color.png">|<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/DisplayType.status.image.png">|<img src="https://github.com/KaoruMuta/IGStoryButtonKit/blob/master/assets/DisplayType.none.png">|
|default color|ColorType.black|ColorType.default|ColorType.clear|ColorType.clear|ColorType.clear|

## Customize Color and Image
You can customize which color is set to circle ring, status view in the lower right named in `statusView` after that and which image is set to status as follows. If you configure display and color type of IGStoryButton, you first import `IGStoryButtonKit` and set value to the property named `condition` derived from `IGStoryButton.TypeCondition` consisted of `IGStoryButton.DisplayType`, `IGStoryButton.ColorType`.

Please refer to these codes, comments and implementation of sample app named in `ExampleApp`.

```swift
// import this module
import IGStoryButtonKit

// storyButton: instance after initialization via code or interface builder
// set displayType as .seen, and default color is set to color of circle ring because colorType is not set specifically 
storyButton.condition = .init(display: .seen)
// same thing with above
storyButton.condition = IGStoryButton.TypeCondition(display: .seen)

// if you set color to statusView, you set StatusView.DisplayType.color(of:) as type and specific color as UIColor in the argument of StatusView.DisplayType.color
storyButton.condition = .init(display: .status(type: .color(of: UIColor.green)))

// if you set image to statusView, you set StatusView.DisplayType.image(of:) as TypeCondition.DisplayType and specific image as UIImage in the argument of StatusView.DisplayType.image
storyButton.condition = .init(display: .status(type: .image(of: UIImage(named: "ramen"))))

// if you customize color of circle ring, you set ColorType.custom(colors:) in the argument as TypeCondition.ColorType and set the specific array consisted of UIColor to the argument of ColorType.custom
storyButton.condition = .init(display: .status(type: .color(of: UIColor.green)), color: .custom(colors: [UIColor.cyan, UIColor.yellow, UIColor.gray]))
```

## Indicator Manipulation
You can manipulate whether circle ring performs like activity indicator or not. If you want to start loading, execute `startAnimating(speed:, alpha:)`. Besides, if you want to stop loading, execute `stopAnimating`.

```swift
// storyButton: instance after initialization via code or interface builder
// if you want to set rotation speed and alpha of button, set these in argument of startAnimating(speed:, alpha):
storyButton.startAnimating() // speed: 0.2, alpha: 0.7
storyButton.stopAnimating()
```

## Important Notification
IGStoryButton is initialized by code or interface builder, but the size of width and height is `required to be equal`. If the size of width is different from one of width, `fatalError("The size of width and height are required to be equal")` is expected to be occurred.

# Requirements
Swift 5.3+<br>
iOS 13.0+<br>
Xcode 12.0+

# Installation
## CocoaPods
Add following to your Podfile and execute `pod install`
```rb
target 'MyApp' do
  pod 'IGStoryButtonKit'
end
```

## Carthage
Add following to your Cartfile and execute `carthage bootstrap --platform iOS --use-xcframeworks`, and finally import xcframeworks in your project
```
github "KaoruMuta/IGStoryButtonKit"
```

## Swift Package Manager
Enter this: `https://github.com/KaoruMuta/IGStoryButtonKit` as Swift Package


# Contribution
If you find any issue, please let me know on Issues. Also, If you propose and implement new features, please open Pull Requests following templates. 

Let's discuss together to improve that this OSS becomes more convenient for developers!
p.s. I'm really happy and improve a motivation to give me star :)

# Future Work
- [ ] Introduce loading animation with dash line to make current animation richer (High Priority, but it seems difficult)
- [ ] Styling design something else (ex. border's width) 
- [ ] Code refactor

# License
Under MIT
