//
//  LivenessOverlayViewModel.swift
//  SelfUI
//
//  Created by Long Pham on 21/5/24.
//

import Foundation
import Combine
import SwiftUI
import AVFoundation

public class LivenessCheckViewModel: ObservableObject {
    @Published var text: String
    @Published public var title: String
    @Published public var subtitle: String
    @Published public var isHighlighted: Bool
    @Published public var attemptNumber: Int
    @Published public var showFailedView: Bool = false
    @Published public var showLivenessCamera: Bool = false
    @Published var tipImageName: String
    @Published public var showVerifyingView: Bool = false
    @Published public var state: Challenge = .None
    @Published public var cameraManager = CameraManager(cameraPosition: .front, captureMode: .captureLiveImage)

    public init(text: String, tipImageName: String, isHighlighted: Bool, attemptNumber: Int = -1, title: String = "title_liveness_capture".localized, subtitle: String = "msg_liveness_check_capture_onboarding".localized) {
        self.text = text
        self.isHighlighted = isHighlighted
        self.tipImageName = tipImageName
        self.attemptNumber = attemptNumber
        self.title = title
        self.subtitle = subtitle
    }
    
    public func update() {
        switch state {
        case .TurnLeft:
            tipImageName = "bg_turn_left"
            text = "selfie_look_left".localized
        case .TurnRight:
            tipImageName = "bg_turn_right"
            text = "selfie_look_right".localized
        case .LookUp:
            tipImageName = "bg_lookup"
            text = "selfie_look_up".localized
        case .LookDown:
            tipImageName = "bg_lookdown"
            text = "selfie_look_down".localized
            
        default:
            print("Not support challenge: \(state)")
            tipImageName = "ic_transparent"
            text = ""
            break
        }
    }
    
    func startCamera() {
        if state == .Done {
            print("LivenessCheck already finished.")
            return
        }
        
        Task(priority: .background) {
            cameraManager.session.startRunning()
        }
    }
    
    func stopCamera() {
        cameraManager.session.stopRunning()
    }
    
    func retry() {
        isHighlighted = false
        state = .None
        showVerifyingView = false
    }
}
