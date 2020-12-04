//
//  RandomFact.swift
//  Random Facts
//
//  Created by Emily Liang on 2020-12-03.
//

import Foundation

struct RandomFact: Codable, Identifiable {
    var id: String = ""
    var text: String = ""
    var source: String = ""
    var source_url: String = ""
    var language: String = ""
    var permalink: String = ""
}
