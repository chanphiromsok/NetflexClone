//
//  Extentions.swift
//  NeflixClon
//
//  Created by rom on 21/7/24.
//

import Foundation


extension String {
    func captalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
