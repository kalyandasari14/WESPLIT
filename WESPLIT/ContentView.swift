//  ContentView.swift
//  tip calculator
//
//  Created by kalyan on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tippingPercentage = 20
    
     var currencies = ["USD","GBP","EUR"]
     
    
    @State private var selectedCurrency = "USD"
    
    @FocusState private var amountIsFocused: Bool
    
    
    
    var GRandTotal: Double{
        let tip = Double(tippingPercentage)
        
        let tipamount = checkAmount/100 * tip
        
         let grandTotal =  checkAmount + tipamount
        
        return grandTotal
    }
    
    var amountPerPerson: Double{
        let people = Double(numberOfPeople )
        return GRandTotal/people
    }
    
   
    var body: some View {
        Section {
            VStack {
                Text("Amount Per Person")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(amountPerPerson, format: .currency(code: selectedCurrency))
                    .font(.system(size: 45, weight: .bold, design: .rounded)) // The "Hero" style
                    .foregroundStyle(color()) // Using your custom color function!
            }
            .frame(maxWidth: .infinity) // Centers everything
            .padding(.vertical)
        }
        NavigationStack{
            List{
                VStack(spacing: 45){
                    Section{
                        TextField("please enter your check amount",value: $checkAmount, format:.currency(code:selectedCurrency))
                            .keyboardType(.decimalPad).focused($amountIsFocused)
                    }
                    Picker("enter the number of people", selection: $numberOfPeople){
                        ForEach(0..<100){
                            Text("\($0)")
                        }
                    }
                    
                    Picker("please select the tip", selection: $tippingPercentage ){
                        ForEach(0..<101){
                            Text("\($0)")
                        }
                    }
                    
                   
                }
                
                Section("grand total will be"){
                    Text(GRandTotal, format: .currency(code: selectedCurrency)).foregroundStyle(color())
                        .opacity(checkAmount > 0 ? 1.0 : 0.3)
                        .grayscale(checkAmount > 0 ? 0 : 1.0)
                }
                
                Section("FInal amount will be per person"){
                    Text(amountPerPerson,format: .currency(code: selectedCurrency))
                }
                
                Picker("currency", selection: $selectedCurrency){
                    ForEach(currencies, id: \.self){
                        Text("\($0)")
                    }
                }
                
               
            }.navigationTitle("We Split").navigationBarTitleDisplayMode(.automatic)
                .toolbar{
                    if amountIsFocused{
                        Button("DONE"){
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
    
    func color() -> Color{
        if tippingPercentage == 0{
            return.red
        }else if tippingPercentage < 20{
            return.orange
        }else {
            return.green
        }
    }
}

#Preview {
    ContentView()
}
