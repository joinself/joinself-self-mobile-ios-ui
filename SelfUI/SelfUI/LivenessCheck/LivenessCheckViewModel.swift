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
    @Published public var isHighlighted: Bool
    @Published var tipImageName: String
    @Published public var state: Challenge = .None
    @Published public var cameraManager = CameraManager(cameraPosition: .front, captureMode: .captureLiveImage)

    public init(text: String, tipImageName: String, isHighlighted: Bool) {
        self.text = text
        self.isHighlighted = isHighlighted
        self.tipImageName = tipImageName
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
}
