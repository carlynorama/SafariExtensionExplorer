//
//  Constants.swift
//  SafariExtensionExplorer
//
//  Created by Carlyn Maw on 1/29/24.
//

//TODO - do I really have to do both?
//https://developer.apple.com/documentation/xcode/configuring-app-groups
//$(TeamIdentifierPrefix){YOURS}.safariextensionland put group on the front.
#if os(macOS)
//$(TeamIdentifierPrefix){YOURS}.safariextensionland
let appGroupName = "group.{YOURS}.safariextensionland"
#else
let appGroupName = "group.{YOURS}.safariextensionland"
#endif




let extensionName = "SafariExtension"
let goodSamplePage = "https://www.whynotestflight.com"


#if os(macOS)
//Used by https://developer.apple.com/documentation/safariservices/sfsafariapplication/2202266-showpreferencesforextension
//Autogenerated when creating example code
let extensionBundleIdentifier = "com.carlynorama.SafariExtensionExplorer.SafariExtension"
#endif
