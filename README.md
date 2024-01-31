#  Safari Extension Explorer


This project, instead of using the Safari Extension full starter app started from a generic blank app.

Steps taken:  

- New Empty Multi-Platform Project
- File > New > Target > (search on Safari, Safari Extension)
- Add the Extension
- BEFORE committing changes, pull the webfiles and create a submodule (see below)
- Add Most Basic SwiftUI Views for MacOS and test
- Add Most Basic SwiftUI Views for iOS, add SDK for iOS to Extension Target
- Change the images to SVG images
- Basic open Safari pages
- Basic send a message: (SFSafariApplication.dispatchMessage, page with extension enabled must be open.)
- Extension & native comms, basic
- Native App and Web Extension Integration: The 2020 documentation says AppGroup or XPCConnection
    - Enable AppGroup (So Containing App Target and Extension Target can talk.)For Each target:
        - Sign&Cap > AppGroup for MacOS and iOSetc bundles
        - Add to same AppGroup 
        - Connect Up UserDefaults
        - TODO: Monitor a folder a la [DocC's Directory Monitor](https://github.com/apple/swift-docc/blob/main/Sources/SwiftDocCUtilities/Utility/DirectoryMonitor.swift)
    - XPCConnection (Unimplemented)
        - https://github.com/ChimeHQ/AsyncXPCConnection
        - https://github.com/CharlesJS/SwiftyXPC
        - (TODO: unix domain sockets vs web sockets for Linux)
- [Improve Layout](https://developer.apple.com/documentation/swiftui/composing_custom_layouts_with_swiftui)

## If you want the app to:

### Send Messages in Background

permissions: nativeMessaging

## Working With the Submodule

### Setting Up
After adding the demo content but before making any commits, drag the extension's Resources up to the same level as the App folder and rename it, to say "DemoExtension". Inside DemoExtension initialize a git repo 
```
cd PATH/TO/SafariExtensionExplorer/SafariExtension
mv Resources ../../DemoExtension
cd ../../DemoExtension
git init . ; git add . ; git commit -m "Initialize repository"
```
Come back to this repo and add the submodule

```
cd ../SafariExtensionExplorer
git -c protocol.file.allow=always submodule add ../DemoExtension/ SafariExtension/Resources
```

in /PATH/TO/DemoExtension git repo create a new branch, but DO NOT CHECK IT OUT.
in the submodules directory, fetch that branch and check it out. 

```
## In the extensions directory
cd /PATH/TO/DemoExtension
git branch forXcproj ##DemoExtension should stay on main. 
## Optionally:
# git remote add xcpjSubmodule /PATH/TO/SafariExtensionExplorer/SafariExtension/Resources


## In the submodule's directory
cd /PATH/TO/SafariExtensionExplorer/SafariExtension/Resources
git status #see it's its own little world.
git remote -v  #see our local folder is origin
git fetch
git checkout forXcproj
## if you already made changes in the submodule's main
## rebasing forXcproj will pull those over.
git rebase main 
```

### Changes

### Get changes

- git -c protocol.file.allow=always submodule update --remote SafariExtension/Resources
- git -c protocol.file.allow=always submodule update --remote --merge

### Send Changes

Make sure that the local repo does not have the branch you're trying to push to checked out our you will get an error like

```
 ! [remote rejected] main -> main (branch is currently checked out)

```

This is why we have created a branch just for the Xcode project. This is also why adding the Xcodproj as a remote might be a good idea. 


## References
- WWDC 2023 talk "[What's New in Safari Extensions](https://developer.apple.com/wwdc23/10119)" 
- https://developer.apple.com/documentation/safariservices/safari_web_extensions
- https://developer.apple.com/documentation/safariservices/safari_web_extensions/messaging_a_web_extension_s_native_app
- NSWorkspace.shared.open(<App url>)
