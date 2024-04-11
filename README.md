
# Running Ex.Co Demo App in Xcode

This guide will walk you through the steps required to get the demo app up and running on your machine using Xcode.

## Prerequisites

- Xcode installed on your macOS machine (You can download it from the Mac App Store).
- CocoaPods installed. If you don't have CocoaPods installed, you can install it by running `sudo gem install cocoapods` in the Terminal.

## Step 1: Clone the Repository

First, you need to clone the demo app repository to your local machine. Open Terminal and run the following command, replacing `URL_OF_THE_REPO` with the actual URL of the repository:

```bash
git clone URL_OF_THE_REPO
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

After installing the dependencies, open the `.xcworkspace` file that CocoaPods generated. This file will be in the root of your project directory. Double-click the file to open it in Xcode, or use the following command in Terminal:

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
