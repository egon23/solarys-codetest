//
//  Meaning.swift
//  solarys-codetest
//
//  Created by Egon Manya on 31.07.24.
//

import Foundation
import RealmSwift

class Meaning: Object, Codable, Identifiable {
    @Persisted var partOfSpeech: String
    @Persisted var definitions = List<Definition>()
}
