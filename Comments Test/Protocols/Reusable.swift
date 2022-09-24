//
//  Reusable.swift
//  Comments Test
//
//  Created by Alina Biesiedina on 2022-09-23.
//

import Foundation


protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
