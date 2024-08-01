//
//  Definition.swift
//  solarys-codetest
//
//  Created by Egon Manya on 31.07.24.
//

import Foundation
import RealmSwift

class Definition: Object, Codable, Identifiable {
    @Persisted var definition: String
    @Persisted var example: String?
}
