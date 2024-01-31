//
//  AdaptiveStack.swift
//  SafariExtensionExplorer
//
//  https://www.hackingwithswift.com/quick-start/swiftui/how-to-automatically-switch-between-hstack-and-vstack-based-on-size-class
//https://developer.apple.com/documentation/swiftui/anylayout

import SwiftUI

struct AdaptiveLayout<Content: View>: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    //@Environment(\.dynamicTypeSize) var dynamicTypeSize
    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content: () -> Content

    init(horizontalAlignment: HorizontalAlignment = .center, verticalAlignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        //let layout = dynamicTypeSize <= .medium ? //&& dynamicTypeSize <= .medium
        let layout = sizeClass != .compact  ?
            AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing)) : AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing))


        layout {
            content()
        }
    }
}
