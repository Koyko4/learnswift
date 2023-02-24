//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tao on 2023/2/24.
//

import Foundation

class ExpenseItem: Identifiable, Codable {
    var id: UUID
    let name: String
    let type: String
    let amount: Double
    let currencySymbol: String // add currencySymbol property
    
    init(name: String, type: String, amount: Double, currencySymbol: String) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.amount = amount
        self.currencySymbol = currencySymbol // initialize currencySymbol property
    }
}

