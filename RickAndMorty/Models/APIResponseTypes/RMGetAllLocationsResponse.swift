//
//  RMGetAllLocationsResponse.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 05.10.2023.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}