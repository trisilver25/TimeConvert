//
//  ContentView.swift
//  TimeConvert
//
//  Created by Tristin Smith on 5/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeAmount = 0.0
    @State private var fromTimeValue = "Seconds"
    @State private var toTimeValue = "Seconds"
    @FocusState private var timeValueIsFocused: Bool
    
    let timeValues = ["Seconds", "Minutes", "Hours", "Days"]
    
    var convertedTime: Double {
        var convertedValue = 0.0
        
        if fromTimeValue == toTimeValue {
            convertedValue = timeAmount
        } else if fromTimeValue == "Seconds" && toTimeValue == "Minutes" {
            convertedValue = timeAmount / 60
        } else if fromTimeValue == "Seconds" && toTimeValue == "Hours" {
            convertedValue =  (timeAmount / 60) / 60
        } else if fromTimeValue == "Seconds" && toTimeValue == "Days" {
            convertedValue = ((timeAmount / 60) / 60) / 24
        } else if fromTimeValue == "Minutes" && toTimeValue == "Seconds" {
            convertedValue = timeAmount * 60
        } else if fromTimeValue == "Minutes" && toTimeValue == "Hours" {
            convertedValue = timeAmount / 60
        } else if fromTimeValue == "Minutes" && toTimeValue == "Days" {
            convertedValue = (timeAmount / 60) / 24
        } else if fromTimeValue == "Hours" && toTimeValue == "Seconds" {
            convertedValue = (timeAmount * 60) * 60
        } else if fromTimeValue == "Hours" && toTimeValue == "Minutes" {
            convertedValue = timeAmount * 60
        } else if fromTimeValue == "Hours" && toTimeValue == "Days" {
            convertedValue = timeAmount / 24
        } else if fromTimeValue == "Days" && toTimeValue == "Seconds" {
            convertedValue = ((timeAmount * 24) * 60) * 60
        } else if fromTimeValue == "Days" && toTimeValue == "Minutes" {
            convertedValue = (timeAmount * 24) * 60
        } else if fromTimeValue == "Days" && toTimeValue == "Hours" {
            convertedValue = timeAmount * 24
        }
        
        return convertedValue
    }
    
    var formatValue: String {
        let value = convertedTime
        return value.formatted(.number)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Convert From") {
                    Picker("Convert From", selection: $fromTimeValue){
                        ForEach(timeValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter Value") {
                    TextField("Time amount", value: $timeAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($timeValueIsFocused)
                    
                    }
                Section("Convert To"){
                    Picker("Convert To", selection: $toTimeValue) {
                        ForEach(timeValues, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Converted Value") {
                    Text("\(formatValue) \(toTimeValue)")
                }
            }
            .navigationTitle("TimeConvert")
            .toolbar {
                if timeValueIsFocused {
                    Button("Done") {
                        timeValueIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
