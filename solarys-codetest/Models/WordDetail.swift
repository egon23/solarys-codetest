//
//  WordDetail.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import RealmSwift

class WordDetail: Object, Codable {
    @Persisted var word: String
    @Persisted var phonetic: String?
    @Persisted var phonetics: List<Phonetic>
    
    override static func primaryKey() -> String? {
        return "word"
    }
}
