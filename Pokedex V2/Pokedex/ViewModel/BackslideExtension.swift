//
//  BackslideExtension.swift
//  Pokedex
//
//  Created by Mahaveer Gill on 30/04/2023.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
