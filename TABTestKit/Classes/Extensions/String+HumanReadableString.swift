//
//  String+HumanReadableString.swift
//  TABTestKit
//
//  Created by Stefan Renne on 09/11/2020.
//

import Foundation

extension String {
    var humanReadableString: String {

        let emptySet = CharacterSet.whitespacesAndNewlines
        let splitSet = emptySet.union(CharacterSet.uppercaseLetters)
        let valueSet = CharacterSet(charactersIn: "\"“”")
        let trimmingSet = emptySet.union(CharacterSet(charactersIn: "?!"))

        return map(Character.init)
            .reduce(into: [String]()) { (result, character) in

                let lastChunk = result.count > 0 ? result[result.count-1] : nil
                let lastCharacter = lastChunk?.last.map(Character.init)

                let isFirstCharachter = result.count == 0
                let isSpitCharacter = splitSet.contains(character: character)
                let isPartOfValue = lastChunk?.occurences(of: valueSet) == 1
                let isPartOfLastChunk = splitSet.contains(character: lastCharacter) && isSpitCharacter && !emptySet.contains(character: character)

                if !isPartOfValue && !isPartOfLastChunk && (isSpitCharacter || isFirstCharachter) {
                    result.append(String(character))
                } else {
                    result[result.count-1].append(character)
                }
            }
            .compactMap { word -> String? in
                let cleanWord = word.trimmingCharacters(in: trimmingSet)
                return cleanWord.isEmpty ? nil : cleanWord
            }
            .map { (word) -> String in
                guard word.contains(where: \.isLowercase) else {
                    return word
                }
                return word.lcfirst
            }
            .joined(separator: " ")
    }
}

extension Sequence where Element == String {
    var humanReadableString: String {
        map(\.humanReadableString)
            .filter { !$0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty }
            .joined(separator: " ")
    }
}

private extension String {
    func occurences(of characterSet: CharacterSet) -> Int {
        reduce(into: 0) { (result, character) in
            guard characterSet.contains(character: character) else { return }
            result += 1
        }
    }

    var lcfirst: String {
        guard let lowercasedFirstCharacter = first?.lowercased() else { return self }
        return ([lowercasedFirstCharacter] + dropFirst().map(String.init)).joined()
    }
}

private extension CharacterSet {
    func contains(character: Character?) -> Bool {
        guard let character = character else { return false }
        return CharacterSet(charactersIn: character.description).isSubset(of: self)
    }
}
