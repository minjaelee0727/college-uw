//
//  PreviewLayoutComponentModifier.swift
//  College-UW (iOS)
//
//  Created by Min Jae Lee on 2021-10-30.
//

import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier {
    let name: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
            .padding()
    }
}

extension View {
    func preview(with name: String) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name))
    }
}
