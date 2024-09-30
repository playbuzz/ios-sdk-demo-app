
# Running Ex.Co Demo App in Xcode

This guide will walk you through the steps required to get the demo app up and running on your machine using Xcode.

## Prerequisites

- Xcode* 14.3+ installed on your macOS machine (You can download it from the Mac App Store).
- CocoaPods installed. If you don't have CocoaPods installed, you can install it by running `sudo gem install cocoapods` in the Terminal.

*You might encounter problems with Xcode 15.3 when using SPM. For that reason said version is not supported at the moment.

## Step 1: Clone the Repository

First, you need to clone the demo app repository to your local machine. Open Terminal and run the following command:

```bash
git clone https://github.com/playbuzz/ios-sdk-demo-app.git
```

## Step 2: Install Dependencies

This demo app uses CocoaPods to manage Ex.Co SDK and its dependencies. Once the repository has been cloned, navigate to the project directory using the Terminal:

```bash
cd PATH_TO_THE_PROJECT_DIRECTORY
```

Replace `PATH_TO_THE_PROJECT_DIRECTORY` with the path where the repository has been cloned.

Next, install the project's dependencies by running:

```bash
pod install
```

This command reads the `Podfile` in the project directory, installs the required dependencies, and sets up an Xcode workspace. 

## Step 3: Open the Project in Xcode

After installing the dependencies, open the newly created `.xcworkspace` file that CocoaPods generated. This file will be in the root of your project directory. Double-click the file to open it in Xcode, or use the following command in Terminal:

```bash
open ExCoSDK-Integration.xcworkspace
```

## Step 4: Run the Demo App

With the project open in Xcode, select an iOS simulator or connect a physical iOS device to run the app on. Then, press the `Run` button in Xcode or use the `Cmd + R` shortcut to build and run the app.

Congratulations! You should now see the demo app running in the selected iOS simulator or on your connected device.

## Troubleshooting

If you encounter any issues while trying to run the app, make sure you have the latest version of Xcode and CocoaPods installed. Also, ensure that you've opened the `.xcworkspace` file, not the `.xcodeproj` file, as the workspace contains all the necessary configurations for the pods.

If you continue to experience problems, try running `pod update` in the project directory to update the dependencies to their latest versions.

---

We hope this guide helps you get started with the demo app. If you have any questions or encounter any issues, please feel free to open an issue in the repository.


# iOS Ex.co SDK

This SDK provides functionality for integrating the Ex.co Player into iOS applications.

## Requirements

- iOS 13.0+
- XCode 14.3+
- Swift 5.0+
- Cocoapods 1.1.1+

## Installation

- **Add the following lines to your `Podfile`**:
```ruby
source 'https://exco1.jfrog.io/artifactory/api/pods/ios-releases-cocoapods-local'
platform :ios, '13.0'

target '<your_app_target_name>' do
use_frameworks!

pod 'ExcoMobileSDK'
pod 'OMSDK_Exco', '~> 1.4.8'

end
```

Then run `pod install`. For further details on the installation and usage of Cocoapods, visit [the official website](https://cocoapods.org).

Go to your project build settings and under Build Options set User Script Sandboxing to NO.
<p align="center">
<img src="https://github.com/playbuzz/ios-sdk/blob/development/ExCoSDK-Development/MobileSDK/MobileSDK/SupportingFiles/ReadmeAssets/user-script-sandboxing.png?raw=true alt="user-script-sandboxing png" />
</p>

## SDK activation

The activation is handled automatically within the SDK. If you wish to activate the SDK manually please add the ExcoMobileSDKManualActivation flag to the applications info plist and set it to true, then follow the instructions below:  

### UIKit

- **To activate the SDK, first import `MobileSDK` to your `AppDelegate`**:
```swift
import MobileSDK
```

- **Add the following lines in `didFinishLaunchingWithOptions` method**:
```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ExcoMobileSDK.delegate = self
        ExcoMobileSDK.activate()
        
        return true
    }
```

- **Conform your `AppDelegate` to `ExcoMobileSDKDelegate`**:
```swift
extension AppDelegate: ExcoMobileSDKDelegate {
    func mobileSDKDidActivateSuccessfully() { }
    
    func mobileSDKDidFailToActivate() { }
    
    func mobileSDKDidFetchSDKJSFiles() { }
}
```

### SwiftUI
- **To activate the SDK, first create an `AppDelegate` class and make it subclass `UIResponder` and conform to `UIApplicationDelegate`**:

```swift
import UIKit
import MobileSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ExcoMobileSDK.delegate = self
        ExcoMobileSDK.activate()
        
        return true
    }
}
```

- **Conform your `AppDelegate` to `ExcoMobileSDKDelegate`**:

```swift
extension AppDelegate: ExcoMobileSDKDelegate {
    func mobileSDKDidFailToActivate() { }
    func mobileSDKDidFetchSDKJSFiles() { }
    func mobileSDKDidActivateSuccessfully() { }
}
```
- **Use `@UIApplicationDelegateAdaptor` to integrate ExcoMobileSDK activation within the SwiftUI lifecycle**.

```swift
@main
struct MyAwesomeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## View - Implementation

You can add an instance of ExcoPlayerView programmatically or using Storyboards/XIBs. Don't forget to import `MobileSDK` to your View Controller.
```swift
import MobileSDK
```

- **To load your player you need to specify a list of parameters as part of `ExcoPlayerConfigurationProtocol`**:

```swift
public protocol ExcoPlayerConfigurationProtocol: NSObjectProtocol {
    public var playerID: String
    public var isProgrammatic: Bool
    public var applicationName: String // Default value provided
    public var applicationBundle: String // Default value provided
    public var applicationVersion: String // Default value provided
    public var applicationCategories: String?
    public var applicationAppstoreId: String?
    public var applicationAppstoreUrl: String?
    public var deviceIdentifier: String?
    public var deviceIFA: String?
    public var isWebInspectable: Bool // Default value provided - true
    public var miniPlayerConfiguration: ExcoMiniPlayerConfiguration
}

public class ExcoMiniPlayerConfiguration: NSObject {
    public let miniPlayerType: ExcoMiniPlayerType // Default value provided
    public var isWithCloseButton: Bool?
    public var isPausingOnClose: Bool?
    public var isPersistent: Bool?
}
```
Check the full documentation for further information regarding `ExcoPlayerConfigurationProtocol`.

## Mini player
ExcoPlayerView includes a mechanism that identifies its location at any given moment. If the view is out of the visible bounds of the screen, a mini player can be displayed in a chosen form out of the following:

```swift
public enum ExcoMiniPlayerType: Equatable {
    case none
    case cornered(in: UIRectCorner)
    case banner(position: BannerPosition)
}

public enum BannerPosition: String, CaseIterable  {
    case top
    case bottom
}
```
Additionally, the mini player has an optional close button that can be configured using `ExcoMiniPlayerConfiguration`.

### Programmatically

- **`ExcoPlayerView` is a `UIView` subclass, it can be added to your View Controller as such**. 
- **MAKE SURE THE ASPECT RATIO OF YOUR PLAYER IS ALWAYS 9:16**.

- **After adding your view you can start configuring it using `ExcoPlayerConfiguration`**:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    let configurationBuilder = ExcoMobileSDK.builder(with: "<YOUR_PLAYER_ID>")
    let configuration = configurationBuilder.build()
    // set shouldStore to true to store configured player in the SDK cache mechanism.
    excoPlayerView.apply(player: configuration, shouldStore: false)
}
```
Replace `<YOUR_PLAYER_ID>` with the player ID provided by Ex.co.

### Storyboard/XIB

- **Add a standard `UIView` to your View Controller. In the identity inspector change the class to `ExcoPlayerView` and module to `MobileSDK`**. 

<p align="center">
<img width="33%" src="https://github.com/playbuzz/ios-sdk/blob/development/ExCoSDK-Development/MobileSDK/MobileSDK/SupportingFiles/ReadmeAssets/identity-inspector.png?raw=true" alt="identity-inspector png" />
</p>

- **MAKE SURE THE ASPECT RATIO OF YOUR PLAYER IS ALWAYS 9:16**.

<p align="center">
<img src="https://github.com/playbuzz/ios-sdk/blob/development/ExCoSDK-Development/MobileSDK/MobileSDK/SupportingFiles/ReadmeAssets/storyboard-player.png?raw=true alt="storyboard-player png" />
</p>

### Reusable player (for UITableView)

 - **Create your custom UITableViewCell containing an instance of ExcoPlayerView.**
 - **Use the method `reuseConfiguration(configuration: ExcoPlayerConfiguration) throws` where you configure your data source**
 ```swift
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellWithPlayerTableViewCell", for: indexPath) as? CellWithPlayerTableViewCell else {
            return UITableViewCell()
        }
        try? cell.playerView.reuseConfiguration(configuration: configuration)
        cell.titleLabel.text = "My Cell"
        
        return cell
    }
 ```
 
### SwiftUI

- **Add `ExcoPlayerSUIView` to your view hierarchy where desired. Said view will expect to receive an instance of `ExcoPlayerConfiguration` and a value for storing the player in the SDK cache mechanism. To read more about caching go to our full Documentation**.

```swift
import SwiftUI
import MobileSDK

struct ContentView: View {
    private var playerConfiguration: ExcoPlayerConfiguration {
        let configurationBuilder = ExcoMobileSDK.builder(with: "<YOUR_PLAYER_ID>")
        return configurationBuilder.build()
    }
    
    var body: some View {
        VStack {
            ExcoPlayerSUIView(configuration: playerConfiguration, shouldStoreInCache: false)
                .frame(width: 320, height: 180) // Aspect Ratio 9:16
        }
        .padding()
    }
}
```
### Reusable player (for List/VStack/LazyVStack)
 - **Create an instance of ExcoPlayerSUIView using the initializer `public init(reusableConfiguration: ExcoPlayerConfiguration)` inside your desired cell.**
 - **Add the `reusable()` modifier to assign a configuration to an existing player or create one if needed, every player created is cached using this method.
 - **Note: Cashed players are retained by the system and will not die until you specifically call on the appropriate ``ExcoMobileSDK`` method.
 ```swift
 var body: some View {
        VStack {
            ExcoPlayerSUIView(reusableConfiguration: configuration)
                .reusable()
            CellWithTitleAndSubtitleOnly(title: title, subtitle: subtitle)
        }
    }
 ```

- **MAKE SURE THE ASPECT RATIO OF YOUR PLAYER IS ALWAYS 9:16**.

<p align="center">
<img width="33%" src="https://github.com/playbuzz/ios-sdk/blob/development/ExCoSDK-Development/MobileSDK/MobileSDK/SupportingFiles/ReadmeAssets/swiftui-player.png?raw=true" alt="swiftui-player png" />
</p>

## `ExcoPlayerViewDelegate`
### Conform to this delegate to get notified about the following player events:
All events:
- `playerView(_ playerView: ExcoPlayerView, didReceiveGenericEventWith payload: NSDictionary)`: Gets all the events sent from web player, including player events, ad slot events, ad events, playlist events and content events. 

Web related events:
- `playerView(_ playerView: ExcoPlayerView, didFinishLoading playerID: String)`: Called when an instance of `ExcoPlayerView` has successfully loaded  web content.
- `playerView(_ playerView: ExcoPlayerView, didFailLoading playerID: String, with error: Error)`: Called when an instance of `ExcoPlayerView` failed loading its web content.

Player related events:
- `playerDidInit(in playerView: ExcoPlayerView)`
- `playerDidLoad(to playerView: ExcoPlayerView)`
- `playerDidStartPlaying(in playerView: ExcoPlayerView)`
- `playerDidPause(in playerView: ExcoPlayerView)`
- `playerDidClose(in playerView: ExcoPlayerView)`
- `playerDidMute (in playerView: ExcoPlayerView)`
- `playerDidUnmute(in playerView: ExcoPlayerView)`
- `playerView(_ playerView: ExcoPlayerView, playerDidEnterFullscreen playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, playerDidExitFullscreen playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didClickCTA playerID: String)`

Ad related events:
- `playerView(_ playerView: ExcoPlayerView, didInitiateAd playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didStartAd playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didImpressAd playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didReachFirstQuartile playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didReachMidpoint playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didReachThirdQuartile playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didCompleteAd playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didSkipAd playerID: String)`
- `playerView(_ playerView: ExcoPlayerView, didClickAd playerID: String)`

Programmatic player events:
- `playerView(_ playerView: ExcoPlayerView, didReceiveSubscription eventName: String, with payload: NSDictionary)`

## Programmatic API
### To gain full control over your player, use the programmatic API.
To begin working with the programmatic API, first set the `isProgrammatic` flag to true in your configuration object.
Programmatic player commands:
- `initProgrammaticPlayer(with options: ExcoPlayerConfigurationOptions?)`: Initialize the player with given optional configuration options.
- `playProgrammaticPlayer()`: Start the content / ad playback for the first time or resume it after pause.
- `pauseProgrammaticPlayer()`: Pause the content / ad playback.
- `getPlaylistIndexInProgrammaticPlayer(completion: @escaping (Int?, Error?) -> Void)`: Retrieve currently-played zero-based playlist item index value.
- `setPlaylistIndexInProgrammaticPlayer(_ index: Int)`: Set zero-based playlist index of content item to be played.
- `getPlaylistItemInProgrammaticPlayer(completion: @escaping (ExcoPlaylistItem?, Error?) -> Void)`: Retrieve currently-played playlist content item.
- `addPlaylistItemsToProgrammaticPlayer(_ items: [ExcoPlaylistItem], at index: Int? = nil)`: Add one or more content video items to current playlist.
- `getContentPositionInProgrammaticPlayer(completion: @escaping (TimeInterval?, Error?) -> Void)`: Returns the currently-played content position in seconds.
- `public func handleProgrammaticFullscreen(isFullScreen: Bool)`: Enter or exit full screen mode.
- `destroyProgrammaticPlayer()`: Destroy the player instance.

#### Subscribe/unsubscribe to events using programmatic player:
`addEventListenerOnProgrammaticPlayer(_ eventName: String, listenerName: String)`: Use this method to subscribe to one of the supported [player events](https://developer.ex.co/#/video-channels/api-reference/on-method?id=player-events).
* The earliest this method can be called is on `playerView(_:didFinishLoading:)`.
* Make sure to remove listeners on `deinit` using `removeEventListenerOffProgrammaticPlayer(_ eventName: String, listenerName: String)`.

`removeEventListenerOffProgrammaticPlayer(_ eventName: String, listenerName: String)`: Use this method to unsubscribe from one of the supported [player events](https://developer.ex.co/#/video-channels/api-reference/on-method?id=player-events).
* The names of the parameters should be identical to the names in `addEventListenerOnProgrammaticPlayer(_:listenerName:)`.

### Related objects:
`ExcoPlayerConfigurationOptions`
```swift
    /// Player playback mode (has higher priority than autoPlay option)
    public var playbackMode: ExcoPlaybackMode?
    /// Autoplay option (has effect only if playbackMode isn't passed)
    public var isAutoPlay: Bool?
    /// Player initial sound state
    public var isMuted: Bool?
    /// Player initial monetization state
    public var shouldShowAds: Bool?
    /// Player content video settings
    public var content: ExcoContentVideoSettings?
    /// Player custom parameters
    public var customParams: NSDictionary?
    /// Player additional parameters that are converted to objects in javascript code
    public var additionalParams: NSDictionary?
```
`ExcoPlaybackMode`
```swift
public enum ExcoPlaybackMode: String {
    case clickToPlay = "click-to-play"
    case autoPlay = "auto-play"
    case playInView = "play-in-view"
}
```
`ExcoContentVideoSettings`
```swift
    /// Playlist items to be played first
    public let firstPlaylist: [ExcoPlaylistItem]?
    /// Indicates that playFirst items should replace the whole playlist
    public let shouldReplacePlaylist: Bool?
    /// Tags to filter the playlist by
    public let tags: [String]?
    /// Playlist id to load the playlist
    public let playlistId: String?
    /// Array of playlist items to be played
    public let playlist: [ExcoPlaylistItem]?
    /// Zero-based playlist start index
    public let playlistIndex: Int?
    /// Playlist-level custom parameters
    public let customParams: NSDictionary?
    /// Playlist-level additional parameters that are converted to objects in javascript code
    public var additionalParams: NSDictionary?
```

`ExcoPlaylistItem`
```swift
    /// Playlist item id
    public let id: String?
    /// Link to video source
    public let src: String
    /// Fallback link that will be used if video source in unavailable
    public let fallback: String?
    /// The link that will be used for TBD
    public let link: String?
    /// Title of the playlist item
    public let title: String?
    /// Description of the playlist item
    public let itemDescription: String?
    /// Link to an image that is shown when the video is loading
    public let poster: String?
    /// Total duration of the video (seconds)
    public let duration: Int?
    /// The tags related to the playlist item
    public let tags: [String]?
    /// The keywords related to the playlist item
    public let keywords: [String]?
    /// Specific playlist item level custom parameters
    public let customParams: NSDictionary?
    /// Specific playlist item level parameters that are converted to objects in javascript code
    public var additionalParams: NSDictionary?
```

### License
- **This project is licensed under the [License Name] - see the LICENSE.md file for details**.
