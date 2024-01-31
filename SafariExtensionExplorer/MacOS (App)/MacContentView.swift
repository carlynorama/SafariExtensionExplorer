//
//  MacContentView.swift
//  WebHelper
//
//  Created by Carlyn Maw on 1/20/24.
//

#if os(macOS)
import SwiftUI

struct MacContentView: View {
    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var viewModel:ViewModel
    @State var enabledStatusText:String = ""
    var body: some View {
        VStack {
           
            Text("Extension is: \(enabledStatusText)")
                .font(.title2)
                .lineLimit(nil)
            
            Button("Quit and Open Safari Settings") {
                Task {
                    await viewModel.openSafariSettings()
                }
            }
            Button("Open Example Page / openURL style") {
                openURL(URL(string: goodSamplePage)!)
            }
            Button("Send Message To Extension") {
                Task {
                    await viewModel.sendBackgroundMessageToExtension(title: "DemoMessage", message: ["Hello":"World"])
                }
            }
            
        }.task {
            await viewModel.setExtensionStatus()
            enabledStatusText = viewModel.isEnabled ? "enabled" : "disabled"
        }
    }


}

#Preview {
    MacContentView()
}
#endif
