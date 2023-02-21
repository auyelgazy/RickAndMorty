//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Kuanysh al-Khattab Auyelgazy on 21.02.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter

    init(character: RMCharacter) {
        self.character = character
    }

    public var title: String {
        return character.name.uppercased()
    }
}
