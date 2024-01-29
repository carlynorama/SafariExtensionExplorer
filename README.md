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
- 

