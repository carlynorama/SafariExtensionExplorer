//
//  AppGroupService.swift
//  SafariExtensionExplorer
//
//  Created by Carlyn Maw on 1/30/24.
//

import Foundation

struct AppGroupService {
    private let appGroupID: String
    private let userDefaults: UserDefaults
    
    
    public func stringForKey(key:some StringProtocol) -> String? {
        userDefaults.string(forKey: key as! String) //as? String
    }
    
    public func setString(_ value: some StringProtocol, forKey key: some StringProtocol) {
        userDefaults.set(value as! String, forKey: key as! String)
    }
    
    public func allDefaults() -> Dictionary<String, Any> {
        userDefaults.dictionaryRepresentation()
    }
    
    public func removeKey(_ key: some StringProtocol) {
        userDefaults.removeObject(forKey: key as! String)
    }

    //for sharedContainerIdentifier if needed.
    var storageLocation:URL? {
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
