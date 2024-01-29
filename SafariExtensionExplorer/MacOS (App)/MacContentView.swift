//
//  MacContentView.swift
//  WebHelper
//
//  Created by Carlyn Maw on 1/20/24.
//

#if os(macOS)
import SwiftUI

struct MacContentView: View {
    @EnvironmentObject var viewModel:ViewModel
    @State var enabledStatusText:String = ""
    var body: some View {
        VStack {
            Text("WebHelper Extension").font(.largeTitle)
            Text("Extension is: \(enabledStatusText)")
                .font(.title2)
                .lineLimit(nil)
            
            Button("Quit and Open Safari Settings") {
                Task {
                    await viewModel.openSafariSetting()
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
