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
    let appGroupService = AppGroupService(appGroupID: appGroupName)
    let messageKey = "message"
    
    func setMessageForApp(_ message:String) {
        appGroupService?.setString(message, forKey: messageKey)
    }


    func beginRequest(with context: NSExtensionContext) {
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
            message = request?.userInfo?[messageKey]
        }

        os_log(.default, "Received message from browser.runtime.sendNativeMessage: %@ (profile: %@)", String(describing: message), profile?.uuidString ?? "none")
        
        
        setMessageForApp(String(describing: message))
            

        let response = NSExtensionItem()
        response.userInfo = [ SFExtensionMessageKey: [ "echo": message ] ]

        context.completeRequest(returningItems: [ response ], completionHandler: nil)
 
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
