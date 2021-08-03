//
//  String+Extension.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation

extension String {
    func getYear() -> String {
        let year = self.split { $0 == "-" }.map(String.init)
        return year.first ?? "1900"
    }
}
