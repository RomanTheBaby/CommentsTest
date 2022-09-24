//
//  NibLoadable.swift
//  Comments Test
//
//  Created by Alina Biesiedina on 2022-09-23.
//

import UIKit


protocol NibLoadable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}
