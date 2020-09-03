//
//  ChecklistView.swift
//  Checklist
//
//  Created by Niq Chambers  on 9/1/20.
//  Copyright © 2020 Niq Chambers . All rights reserved.
//

import SwiftUI


struct ChecklistView: View {
    
    // Properties
    // ============
    
    @ObservedObject var checklist = Checklist()
    @State var newChecklistItemViewIsVisible = false
    
    
    //User interface content and layout
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(checklist.items) { index in RowView(checklistItem: self.$checklist.items[index])}
                .onDelete(perform: checklist.deleteListItem)
                .onMove(perform: checklist.moveListItem)
                
            }
        .navigationBarItems(
            leading: Button(action: { self.newChecklistItemViewIsVisible = true}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add item")
                }
            },
            trailing: EditButton()
            )
                
                .navigationBarTitle("Checklist", displayMode: .inline)
            
                .onAppear() {
                    self.checklist.printChecklistContents()
                    self.checklist.saveListItems()
            }
        }
        .sheet(isPresented: $newChecklistItemViewIsVisible) {
            NewChecklistItemView(checklist: self.checklist)
        }
        
    }
    
    // Methods
    // =========
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
