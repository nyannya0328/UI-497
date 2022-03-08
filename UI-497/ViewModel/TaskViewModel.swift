//
//  TaskViewModel.swift
//  UI-497
//
//  Created by nyannyan0328 on 2022/03/07.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var addNewTask : Bool = false
    @Published var editeTask : Task?
    
    
    @Published var currentWeek : [Date] = []
    
    @Published var currentDay : Date = Date()
    
    
    
    init() {
        
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek(){
        
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        
        
        guard let firstWeekDay = week?.start else{return}
        
        (0..<6).forEach { day in
            
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                
                
                currentWeek.append(weekDay)
            }
            
            
        }
        
    }
    
    func extractDate(date : Date,format : String) -> String{
        
        
        
        let formated = DateFormatter()
        
        
        formated.dateFormat = format
        
        
        return formated.string(from: date)
    }
    
    func isToday(date : Date) -> Bool{
        
        
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
        
        
        
        
    }
    
    
    func isCurrentHour(date : Date) -> Bool{
        
        
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        let currentHour = calendar.component(.hour, from: date)
        
        let isToday = calendar.isDateInToday(date)
        
        
        
        
        return (hour == currentHour && isToday)
        
        
    }
    
    
    
    
    
}

