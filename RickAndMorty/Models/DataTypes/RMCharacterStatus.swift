//
//  RMCharacterStatus.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 18.02.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    var text: String {
        switch self {
        case .alive, .dead:
            return self.rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
