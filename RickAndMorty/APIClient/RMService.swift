//
//  RMService.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 18.02.2023.
//

import Foundation

/// Primary API service to get Rick and Morty data
final class RMService {

    /// Shared singleton instance
    static let shared = RMService()

    /// Privatized constructor
    private init() {}

    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
}
