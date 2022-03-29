//
//  File.swift
//  
//
//  Created by robevans on 3/29/22.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
func playHaptic(style: String) {
    switch style {
    case "error":
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    case "heavy":
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    case "medium":
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    default:
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
}
