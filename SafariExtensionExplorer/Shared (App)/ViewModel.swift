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


class ViewModel:ObservableObject {
    var isEnabled = false
    
    
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
    

    
//    //Already exists: https://developer.apple.com/documentation/safariservices/sfsafariapplication/1639493-openwindow
//    func openWindow(with url: URL) async ->  SFSafariWindow? {
//        await withCheckedContinuation { continuation in
//            SFSafariApplication.openWindow(with: url) { window in
//                continuation.resume(returning: window)
//            }
//        }
//    }
    
#endif
}



//MARK: Storage

//Deprecated? methods for opening safari windows?
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
 */
