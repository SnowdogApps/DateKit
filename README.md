![Pod version](https://cocoapod-badges.herokuapp.com/v/DateKit/badge.png)
![Platform](https://cocoapod-badges.herokuapp.com/p/DateKit/badge.png)
![License](https://cocoapod-badges.herokuapp.com/l/DateKit/badge.png)
![Tests](https://travis-ci.org/SnowdogApps/DateKit.svg?branch=master)

# DateKit README #

![DateKit](https://snowdog.co/wp-content/uploads/2015/01/IMG-2865.jpg)

## What is DateKit?

* *DateKit* is a simple Swift framework to simplify operations on NSDate instances.
* Version: 0.1.1

## Installation

You can use CocoaPods to add it to your Swift project. Just add `pod 'DateKit'` and run `pod install`.

For iOS 7.0 you can add DateKit as submodule. To do that you need first:

```
git submodule add https://github.com/SnowdogApps/DateKit
```

Then add DateKit.framework to Target Dependencies and Link Binary With Libraries.
Now you can import DateKit where you want to use it.

### Swift 1.2

For Swift 1.2 we recommend to refer to the latest commit on master branch in your Podfile:

```
pod 'DateKit',
    :git => "https://github.com/SnowdogApps/DateKit.git",
    :commit => "latest commit sha",
    :branch => "master"
```

## Development

DateKit requires Quick and Nimble (bdd and matchers frameworks). They can be added manually to DateKit project. Download [Quick](https://github.com/Quick/Quick) and [Nimble](https://github.com/Quick/Nimble) from Github and add them to DateKit project.

Alternatively you can use CocoaPods. There is a Podfile in DateKit, so all you need to do is to run code below (in Terminal):

```
pod install
```
Please remember that CocoaPods are in beta for Swift. Don't forget to get pre-release version of CocoaPods: `gem install cocoapods --pre`.
Close DateKit project. Open DateKit.xcworkspace file and run tests as usually (cmd + U).

## Playground
There's a Playground on the repo, so you can play a bit with DateKit. To use Playground create a workspace with DateKit.project (or use the one created by cocoapods), build DateKit, and then drag playground into the workspace. Have fun!

Any questions can be asked to r.szeja@snowdog.pl
