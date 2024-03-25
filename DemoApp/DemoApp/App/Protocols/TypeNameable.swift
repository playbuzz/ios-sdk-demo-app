//
//  TypeNameable.swift
//  DemoApp
//
//  Created by Eli Mehaudy on 25/03/2024.
//

import Foundation

protocol TypeNameable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension TypeNameable {
    var typeName: String { return String(describing: self) }
    static var typeName: String { return String(describing: Self.self) }
}
