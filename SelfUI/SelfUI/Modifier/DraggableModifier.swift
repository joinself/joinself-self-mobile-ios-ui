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
    
    enum SwipeDirection {
        case left
        case right
        case up
        case down
    }

    let direction: Direction

    @State private var draggedOffset: CGSize = .zero
    let SWIPE_MIN_DISTANCE: CGFloat = 100
    private var onSwipe: ((SwipeDirection) -> Void)?
    init(direction: Direction = .horizontal, draggedOffset: CGSize = .zero, onSwipe: ((SwipeDirection) -> Void)? = nil) {
        self.direction = direction
        self.draggedOffset = draggedOffset
        self.onSwipe = onSwipe
    }

    func body(content: Content) -> some View {
        content
        .offset(
            CGSize(width: direction == .vertical ? 0 : draggedOffset.width,
                   height: direction == .horizontal ? 0 : draggedOffset.height)
        )
        .gesture(
            DragGesture(minimumDistance: 20)
            .onChanged { gesture in
                self.draggedOffset = gesture.translation
            }
            .onEnded { gesture in
                if gesture.translation.width > SWIPE_MIN_DISTANCE {
                    print("Swipe Left to Right")
                    onSwipe?(.right)
                } else if gesture.translation.width < -SWIPE_MIN_DISTANCE {
                    print("Swipe Right to Left")
                    onSwipe?(.left)
                }
                self.draggedOffset = .zero
            }
        )
    }

}
