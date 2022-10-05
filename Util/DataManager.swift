//
//  DataManager.swift
//  Tutorial
//
//  Created by Leah on 2022/10/05.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    var contacts: [Contact] = []
}
