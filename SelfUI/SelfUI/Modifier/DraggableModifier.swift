//
//  DraggableModifier.swift
//  SelfUI
//
//  Created by Long Pham on 7/1/25.
//

import SwiftUI

struct DraggableModifier : ViewModifier {

    enum Direction {
        case vertical
        case horizontal
    }

    let direction: Direction

    @State private var draggedOffset: CGSize = .zero

    func body(content: Content) -> some View {
        content
        .offset(
            CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                   height: direction == .horizontal ? 0 : draggedOffset.height)
        )
        .gesture(
            DragGesture()
            .onChanged { value in
                self.draggedOffset = value.translation
            }
            .onEnded { value in
                self.draggedOffset = .zero
            }
        )
    }

}
