//
//  MacOSViewModel.swift
//  WebHelper
//
//  Created by Carlyn Maw on 1/20/24.
//


import SwiftUI

import SafariServices.SFSafariApplication
#if os(macOS)
import SafariServices.SFSafariExtensionManager
#endif
import os.log


final class ViewModel:ObservableObject {
    init() {
        self.isEnabled = false
        self.messageService = AppGroupService(appGroupID: appGroupName)!
        self.messageService.setToExtensionMessage(to: "first message")
        self.messageService.setToExtensionMessage(to: "different first message")
    }
    
    let randomWords = ["roomy",
                       "clean",
                       "kaput",
                       "several",
                       "groovy",
                       "quickest",
                       "squalid",
                       "lopsided",
                       "peaceful",
                       "savory"]
    
    var isEnabled = false
    
    //MARK: Transfer with Extension Target
    let messageService:AppGroupService

    func getExtensionMessage() -> String {
        //"Not active."
        messageService.getFromExtensionMessage() ?? "No Message yet."
    }
    
    func sendExtensionMessage() {
        messageService.setToExtensionMessage(to: randomWords.randomElement()!)
    }
    
    //MARK: MacOS Only Functions
#if os(macOS)
    func setExtensionStatus() async {
        do {
            isEnabled = try await SFSafariExtensionManager.stateOfSafariExtension(withIdentifier: extensionBundleIdentifier).isEnabled
        } catch {
            await NSApp.presentError(error)
        }
    }
    
    func openSafariSettings() async {
        do {
            try await SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier)
            //kills the app.
            //If don't kill the app, rewrite so view with status is flagged as stale somehow.
            await NSApplication.shared.terminate(nil)
        } catch {
            await NSApp.presentError(error)
        }
    }
    
    func sendBackgroundMessageToExtension(title:some StringProtocol, message:Dictionary<String,String>) async {
        do {
            try await dispatchMessage(title: title, message: message)
            os_log(.default, "Dispatching message to the extension finished")
        } catch {
            os_log(.default, "\(error)")
        }
    }
    
    func sendBackgroundMessageToExtension(title:some StringProtocol, message:Dictionary<String,String>) {
        SFSafariApplication.dispatchMessage(withName: title as! String, toExtensionWithIdentifier: extensionBundleIdentifier, userInfo: message) { (error) -> Void in
            os_log(.default, "Dispatching message to the extension finished \(error)")
        }
    }
    
    //MARK: async wrappers on SFSafariApplication
    
    func dispatchMessage(title:some StringProtocol, message:Dictionary<String,String>) async throws {
        let result = await withCheckedContinuation { continuation in
            SFSafariApplication.dispatchMessage(withName: title as! String, toExtensionWithIdentifier: extensionBundleIdentifier, userInfo: message) { messages in
                continuation.resume(returning: messages)
            }
        }
        if result != nil { throw result! }
        
    }
#endif
}


