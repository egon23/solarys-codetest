//
//  Phonetic.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import RealmSwift

class Phonetic: Object, Codable, Identifiable {
    @Persisted var id: UUID = UUID()
    @Persisted var text: String?
    @Persisted var audio: String?
    
    // Specify coding keys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case text, audio
    }
}
