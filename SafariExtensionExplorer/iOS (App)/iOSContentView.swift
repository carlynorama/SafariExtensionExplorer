//
//  iOSContentView.swift
//  WebHelperExtension
//
//  Created by Carlyn Maw on 1/20/24.
//

#if !os(macOS)
import SwiftUI

struct iOSContentView: View {
    var body: some View {
        VStack {
            Text("Turn on the Safari extension \(extensionName) in “Settings › Safari”")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Open Settings") {
                // Get the settings URL and open it
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Open an Example Page") {
                if let url = URL(string: "https://en.wikipedia.org/wiki/Fish") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}

#Preview {
    iOSContentView()
}
#endif
