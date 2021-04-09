//
//  Optional+Extensions.swift
//  ListingCharacters
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.04.21.
//

import Foundation

extension Optional {
    func unwrapOrDie(file: StaticString = #file, line: UInt = #line, function: StaticString = #function) -> Wrapped {
        if let value = self { return value }
        fatalError("Error trying to unwrap value from type \(Wrapped.self). \(file):\(line)/\(function)")
    }
}
