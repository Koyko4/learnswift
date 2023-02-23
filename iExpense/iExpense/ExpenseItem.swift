//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tao on 2023/2/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
