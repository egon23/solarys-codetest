//
//  WordDetail.swift
//  solarys-codetest
//
//  Created by Egon Manya on 30.07.24.
//

import Foundation
import RealmSwift

class WordDetail: Object, Codable, Identifiable {
    @Persisted var word: String
    @Persisted var phonetic: String?
    @Persisted var phonetics = List<Phonetic>()
    @Persisted var origin: String?
    @Persisted var meanings = List<Meaning>()
    
    override static func primaryKey() -> String? {
        return "word"
    }
}

// sample data
extension WordDetail {
    static var sampleData: [WordDetail] {
        let word1 = WordDetail()
        word1.word = "hello"
        word1.phonetic = "həˈləʊ"
        word1.origin = "early 19th century: variant of earlier hollo; related to holla."
        
        let phonetic1 = Phonetic()
        phonetic1.text = "həˈləʊ"
        phonetic1.audio = "//ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3"
        word1.phonetics.append(phonetic1)
        
        let meaning1 = Meaning()
        meaning1.partOfSpeech = "exclamation"
        
        let definition1 = Definition()
        definition1.definition = "used as a greeting or to begin a phone conversation."
        definition1.example = "hello there, Katie!"
        meaning1.definitions.append(definition1)
        
        word1.meanings.append(meaning1)
        
        let word2 = WordDetail()
        word2.word = "world"
        word2.phonetic = "wɜːld"
        
        return [word1, word2]
    }
}
