#  Safari Extension Explorer

- New Empty Multi-Platform Project
- File > New > Target > (search on Safari, Safari Extension)
- Add the Extension
- BEFORE committing changes
    - pull all the files out of Resources into their own directory at the same level as the App ("DemoExtension") and delete the directory
    - in DemoExtension, initialize the repo 
        - (`git init . ; git add . ; git commit -m "Initialize repository"`)
    - in SafariExtensionExplorer
        - `git -c protocol.file.allow=always submodule add ../DemoExtension/ SafariExtension/Resources`
- Add Most Basic Views for MacOS and test
- Add Most Basic Views for iOS, add SDK for iOS to Extension Target


## References
- WWDC 2023 talk "[What's New in Safari Extensions](https://developer.apple.com/wwdc23/10119)" 
- https://developer.apple.com/documentation/safariservices/safari_web_extensions
