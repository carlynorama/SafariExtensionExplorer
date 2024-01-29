//
//  MacOSViewModel.swift
//  WebHelper
//
//  Created by Carlyn Maw on 1/20/24.
//

#if os(macOS)
import SwiftUI

import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager
import os.log


class ViewModel:ObservableObject {
    var isEnabled = false
    
    func setExtensionStatus() async {
        do {
            isEnabled = try await SFSafariExtensionManager.stateOfSafariExtension(withIdentifier: extensionBundleIdentifier).isEnabled
        } catch {
            await NSApp.presentError(error)
        }
    }

    func openSafariSetting() async {
        do {
            try await SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier)
            //kills the app.
            //If don't kill the app, rewrite so view with status is flagged as stale somehow.
            await NSApplication.shared.terminate(nil)
        } catch {
            await NSApp.presentError(error)
        }
    }
}
#endif
