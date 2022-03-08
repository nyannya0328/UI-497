//
//  NewTaskView.swift
//  UI-497
//
//  Created by nyannyan0328 on 2022/03/07.
//

import SwiftUI

struct NewTaskView: View {
    
    @State var taskTitle : String = ""
    @State var taskDescription : String = ""
    @State var taskDate : Date = Date()
    
    @EnvironmentObject var model : TaskViewModel
    
    @Environment(\.managedObjectContext) var context
    
    @Environment(\.dismiss) var dissmiss
    var body: some View {
        NavigationView{
            
            
            List{
                
                
                Section {
                    
                    
                    TextField("Go to Work", text: $taskTitle)
                    
                } header: {
                    
                    
                    Text("Task Title")
                    
                    
                }
                
                
                Section {
                    
                    
                    TextField("TaskDescription", text: $taskDescription)
                    
                } header: {
                    
                    
                    Text("Task Description")
                    
                    
                }
                
                if model.editeTask == nil{
                    
                    
                    Section {
                        
                        DatePicker("", selection: $taskDate)
                            .datePickerStyle(.graphical)
                        
                    } header: {
                        
                        
                    }

                }
                
                
                

                
                
                
            }
            .listStyle(.insetGrouped)
            .interactiveDismissDisabled(true)
            .navigationTitle("Add New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        
                        
                        if let task = model.editeTask{
                            
                            
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                        }
                        
                        else{
                            
                            
                          let task = Task(context: context)
                            
                            task.taskTitle = taskTitle
                            task.taskDescription = taskDescription
                            task.taskDate = taskDate
                            
                            
                            try? context.save()
                            
                            dissmiss()
                            
                            
                            
                        }
                        
                    } label: {
                        
                        Text("Save")
                    }
                    .disabled(taskTitle == "" || taskDescription == "")

                    
                    
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        
                        dissmiss()
                        
                    } label: {
                        
                        Text("Cancel")
                    }

                    
                    
                }
            }
            .onAppear {
                if let task = model.editeTask{
                    
                    taskTitle = task.taskTitle ?? ""
                    taskTitle = task.taskDescription ?? ""
                    
                }
                
            }
        
            
            
            
        }
       
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
