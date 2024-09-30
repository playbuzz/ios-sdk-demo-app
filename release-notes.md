# Release Notes for ExcoMobileSDK(iOS)

## Version 1.1.9 - 30/9/2024
### Features
- **Reusable Player screens added**
  
## Version 1.1.7 - 18/9/2024
### Features
- **Full screen mode support in programmatic player**
- **ExcoPlayerView support in recycle views:**
 - ExcoPlayerView support for UITableView and UICollectionView using UIKit.
 - ExcoPlayerView support for List, VStack and LazyVStack using SwiftUI.

### Bug Fixes
- **SwiftUI crash when cache param is true**
  - Issue: App crashes when trying to reopen SwiftUI based player that is cached in memory. 
  - Resolution: Retain cycle found and fixed.
  
## Version 1.1.6 (snapshot & release) - 9/6/2024

### Deprecations
- ** `@objc public class func prefetchSDKJSFiles()` method in `ExcoMobileSDK`**
  - Details: Method is handled within the activation of the SDK.
