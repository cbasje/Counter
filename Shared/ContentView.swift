//
//  ContentView.swift
//  Shared
//
//  Created by Sebastiaan on 07/08/2020.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("count") var count: Int = 0
    
    @State var showSheet = false
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            Sidebar()
            #endif
            
            VStack {
                Spacer()
                
                Button(action: {
                    count += 1
                    hapticFeedback()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                
                Text("\(count)").padding()
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                
                Button(action: {
                    count -= 1
                    hapticFeedback()
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                
                Spacer()
                
                Text("Love you and I'm proud of you")
                    .font(.footnote)
                    .opacity(0.3)
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    ShareButton(activityItems: ["Total count is \(count)"])
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Image(systemName: "plus.square.on.square")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AddSheet(count: $count)
            })
        }
    }
    
    func hapticFeedback() {
        #if os(iOS)
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AddSheet: View {
    @Environment(\.presentationMode) var pm
    
    @Binding var count: Int
    @State var addString = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Add a number", text: $addString)
//                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: {
                        count = 0
                        pm.wrappedValue.dismiss()
                    }) {
                        Text("Reset counter")
                            .foregroundColor(.red)
                    }
                }
            }
//            .navigationBarItems(trailing: Button(action: {
//                count += Int(addString) ?? 0
//                pm.wrappedValue.dismiss()
//            }, label: {
//                Text("Save")
//            }))
        }
    }
}

struct Sidebar: View {
    var body: some View {
        List(1..<10) { i in
            Label("Row \(i)", systemImage: "circle")
        }
        .listStyle(SidebarListStyle())
    }
}
