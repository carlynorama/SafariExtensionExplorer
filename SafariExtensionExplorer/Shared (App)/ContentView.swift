//
//  ContentView.swift
//  SafariExtensionExplorer
//
//  Created by Carlyn Maw on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    @State var messageFromExtension:String = "Haven't heard"
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image(systemName: "safari.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("WebHelper Extension").font(.largeTitle)
            
            AdaptiveLayout {
               Group {
                    Text(messageFromExtension)
                    Button("Check Messages") {
                        messageFromExtension = viewModel.getExtensionMessage()
                    }
                    Button("Send Message") {
                       viewModel.sendExtensionMessage()
                    }
                }
#if os(macOS)
                MacContentView().environmentObject(viewModel)
#else
                iOSContentView().environmentObject(viewModel)
#endif
                
            }
            .padding()
            
            
        }
    }
}

#Preview {
    ContentView()
}
