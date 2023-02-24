//
//  ContentView.swift
//  iExpense
//
//  Created by Tao on 2023/2/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    private let currencies = ["USD", "EUR", "GBP", "JPY", "CNY"] // available currencies
    @State private var currencySymbol: String
    @State private var showingAddExpense = false // to show the AddView
    
    
    init() {
        _ = Locale.current.currency?.identifier ?? "USD"
        let locale = Locale(identifier: Locale.current.identifier)
        self.currencySymbol = locale.currencySymbol ?? "$"
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal")) {
                    ForEach(expenses.personalItems) { item in
                        self.rowView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section(header: Text("Business")) {
                    ForEach(expenses.businessItems) { item in
                        self.rowView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses, onCommit: { currency in
                    let locale = Locale(identifier: Locale.current.identifier)
                    self.currencySymbol = locale.currencySymbol ?? "$"
                })
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            if let itemIndex = expenses.items.firstIndex(where: { $0.id == expenses.items[index].id }) {
                expenses.items.remove(at: itemIndex)
            }
        }
    }
    
    private func rowView(item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text("\(item.currencySymbol)\(item.amount, specifier: "%.2f")")
                .foregroundColor(getAmountColor(amount: item.amount))
        }
    }
    
    func getAmountColor(amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .orange
        } else {
            return .red
        }
    }
}

struct GPTContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

