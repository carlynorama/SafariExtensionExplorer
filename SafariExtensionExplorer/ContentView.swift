//
//  ContentView.swift
//  SafariExtensionExplorer
//
//  Created by Carlyn Maw on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "safari.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
#if os(macOS)
            MacContentView().environmentObject(viewModel)
#else
            iOSContentView()
#endif

        }
        .padding()
        
 
        
    }
}

#Preview {
    ContentView()
}
