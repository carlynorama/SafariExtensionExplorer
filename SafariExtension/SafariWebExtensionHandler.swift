//
//  SafariWebExtensionHandler.swift
//  SafariExtension
//
//  Created by Carlyn Maw on 1/29/24.
//

import SafariServices
import os.log

//let SFExtensionMessageKey = "message"  //in some example apps not others.



class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    //private var context: NSExtensionContext?
    
    //MARK: Transfer with Extension Target
    let messageService = AppGroupService(appGroupID: appGroupName)!
    
    func setMessageForApp(_ message:String) {
        messageService.setToNativeMessage(to: message)
    }
    
    func getMessageFromApp() -> String? {
        //"Nothing."
        messageService.getFromNativeMessage()
    }

    func beginRequest(with context: NSExtensionContext) {
        var responseContent: [ String : Any ] = [ : ]
        defer {
            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: responseContent ]
            context.completeRequest(returningItems: [ response ], completionHandler: nil)
        }
        
        let request = context.inputItems.first as? NSExtensionItem

        let profile: UUID?
        if #available(iOS 17.0, macOS 14.0, *) {
            profile = request?.userInfo?[SFExtensionProfileKey] as? UUID
        } else {
            profile = request?.userInfo?["profile"] as? UUID
        }

        let message: Any?
        if #available(iOS 17.0, macOS 14.0, *) {
            message = request?.userInfo?[SFExtensionMessageKey]
        } else {
            message = request?.userInfo?[messageService.fromExtensionKey]
        }

        os_log(.debug, "Received message from browser.runtime.sendNativeMessage: %@ (profile: %@)", String(describing: message), profile?.uuidString ?? "none")

        responseContent["echo"] = message
        setMessageForApp(String(describing: message))
        
        let newMessage = getMessageFromApp() ?? "I'll say this"
        responseContent[messageService.fromNativeKey] = newMessage
    }
    
    
    
    

}

//STORAGE:

//simpler version from WWDC 2023 talk "What's New in Safari Extensions"
//https://developer.apple.com/wwdc23/10119
//func beginRequest(with context: NSExtensionContext) {
//        guard let item = context.inputItems.first as? NSExtensionItem, let userInfo = item.userInfo as? [String:Any] else {
//            return
//        }
//
//        if let profileIdentifier = userInfo[SFExtensionProfileKey] as? UUID {
//            //Perform profile specific tasks
//        } else {
//            //non-specific tasks
//        }
    //...
//}



//MARK: Storage for Safari Extension

//NO. Old style. Not available on iOS.
//class SafariExtensionHandler: SFSafariExtensionHandler {
//    override func messageReceivedFromContainingApp(
//        withName messageName: String,
//        userInfo: [String : Any]? = nil
//    ) {
//        print("hello?")
//        os_log(.debug, "Received message from containing app: %@ : %@", String(describing: messageName), String(describing: userInfo))
//    }
//}

// Tried to put in NativeAp view model, incorrect. 
// The other methods were not missing the context.
//No current extension context; trying most recent context
//No most recent extension context
//No extension context for best match
//No extension context for remote object
/*
 
 //    //https://developer.apple.com/documentation/safariservices/sfsafariwindow
 func openWindow(with url:URL?) async {
 guard let url else {
 print("url not valid")
 os_log(.error, "url not valid")
 //TODO pass message back to UI
 return
 }
 os_log(.debug, "url valid")
 if let window = await SFSafariApplication.openWindow(with: url) {
 //https://developer.apple.com/documentation/safariservices/sfsafaritoolbaritem
 if let toolBarItem = await window.toolbarItem() {
 toolBarItem.setBadgeText("!")
 }
 //            func setBadgeText(String?)
 //            Sets the badge text for the toolbar item.
 //            func setEnabled(Bool)
 //            Sets whether the toolbar item is enabled.
 //            func setImage(NSImage?)
 //            Sets the image displayed in the toolbar button.
 //            func setLabel(String?)
 //            Instance Methods
 //            func showPopover()
 }
 os_log(.debug, "window open attempts over?")
 }
 
 
 func checkForWindow() async {
     if let window = await  SFSafariApplication.activeWindow() {
         print(window)
     } else {
         print("No active window")
     }
 }
 
 func replaceActiveTab(with url:URL?) async {
 guard let url else {
 print("url not valid")
 os_log(.error, "url not valid")
 //TODO pass message back to UI
 return
 }
 os_log(.debug, "url valid")
 
 if let window = await SFSafariApplication.activeWindow() {
 //https://developer.apple.com/documentation/safariservices/sfsafaritab
 if let tab = await window.activeTab() {
 //https://developer.apple.com/documentation/safariservices/sfsafaripage
 let page = await tab.activePage()
 //func getScreenshotOfVisibleArea(completionHandler: (NSImage?) -> Void)
 //func reload()
 //func dispatchMessageToScript(withName: String, userInfo: [String : Any]?)
 //Dispatches a message from the app extension to the content script injected in this page.
 //https://developer.apple.com/documentation/safariservices/sfsafaripageproperties
 if let properties = await page?.properties() {
 os_log(.default, "replacing \"\(properties.title ?? "")\" with \(url)")
 }
 tab.navigate(to: url)  //how to make sure await arrival?
 }
 }
 }
 
     //Already exists: https://developer.apple.com/documentation/safariservices/sfsafariapplication/1639493-openwindow
     func openWindow(with url: URL) async ->  SFSafariWindow? {
         await withCheckedContinuation { continuation in
             SFSafariApplication.openWindow(with: url) { window in
                 continuation.resume(returning: window)
             }
         }
     }
 */
