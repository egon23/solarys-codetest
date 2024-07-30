//
//  Phonetic.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import RealmSwift

class Phonetic: Object, Codable {
    @Persisted var text: String?
    @Persisted var audio: String?
}
