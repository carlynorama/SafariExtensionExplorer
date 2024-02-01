//
//  AppGroupService.swift
//  SafariExtensionExplorer
//
//  Created by Carlyn Maw on 1/30/24.
//

import Foundation

protocol SEMessageService {
    var fromExtensionKey: String { get }
    var fromNativeKey: String { get }
    
    func setToExtensionMessage(to:some StringProtocol)
    func getFromExtensionMessage() -> String?
    func setToNativeMessage(to:some StringProtocol)
    func getFromNativeMessage() -> String?
}


struct AppGroupService {
    private let appGroupID: String
    private let userDefaults: UserDefaults
    
    
    private func stringForKey(_ key:some StringProtocol) -> String? {
        userDefaults.string(forKey: key as! String) //as? String
    }
    
    private func setString(_ value: some StringProtocol, forKey key: some StringProtocol) {
        userDefaults.set(value as! String, forKey: key as! String)
    }
    
    private func allDefaults() -> Dictionary<String, Any> {
        userDefaults.dictionaryRepresentation()
    }
    
    private func removeKey(_ key: some StringProtocol) {
        userDefaults.removeObject(forKey: key as! String)
    }

    //for sharedContainerIdentifier if needed.
    private var storageLocation:URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:appGroupID)
    }
}

extension AppGroupService {
    init?(appGroupID: String) {
        self.appGroupID = appGroupID
        guard let userDefs = UserDefaults(suiteName: appGroupID) else {
            return nil
        }
        self.userDefaults = userDefs
    }
}

extension AppGroupService:SEMessageService {
    var fromExtensionKey:String { "message" }
    var fromNativeKey:String { "messageNtE" }
    

    func setToExtensionMessage(to message: some StringProtocol) {
        setString(message, forKey:fromNativeKey)
    }
    
    func getFromExtensionMessage() -> String? {
        stringForKey(fromExtensionKey)
    }
    
    func setToNativeMessage(to message: some StringProtocol) {
        setString(message, forKey:fromExtensionKey)
    }
    
    func getFromNativeMessage() -> String? {
        stringForKey(fromNativeKey)
    }
    
}
