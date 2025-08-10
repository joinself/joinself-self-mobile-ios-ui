//
//  KeyboardResponder.swift
//  SelfUI
//
//  Created by Long Pham on 1/10/24.
//

import SwiftUI
import Combine

public class KeyboardResponder: ObservableObject {
    @Published public var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?
    
    public init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification in
                guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return nil }
                return notification.name == UIResponder.keyboardWillHideNotification ? 0 : frame.height
            }
            .assign(to: \.currentHeight, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
}
