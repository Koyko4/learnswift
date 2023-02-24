//
//  AddView.swift
//  iExpense
//
//  Created by Tao on 2023/2/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    
    @ObservedObject var expenses: Expenses
    let currencies = ["USD", "EUR", "GBP", "JPY", "CNY"] // available currencies
    let onCommit: (String) -> Void // closure to pass the selected currency symbol back to the ContentView
    @State private var selectedCurrency = "USD" // selected currency symbol
    @Environment(\.presentationMode) var presentationMode // to dismiss the view
    
    // ...
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type) {
                        ForEach(["Personal", "Business"], id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                }
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing:
                                    Button("Save") {
                if let actualAmount = Double(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount, currencySymbol: selectedCurrency)
                    expenses.items.append(item)
                    onCommit(selectedCurrency) // pass the selected currency back to the ContentView
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showingAlert = true
                }
            }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Invalid amount"), message: Text("Please enter a valid amount."), dismissButton: .default(Text("OK")))
                }
            )
        }
    }
}



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), onCommit: { _ in })
    }
}
