//
//  DynamicFileterView.swift
//  UI-497
//
//  Created by nyannyan0328 on 2022/03/08.
//

import SwiftUI
import CoreData


struct DynamicFileterView<Content : View,T>: View where T : NSManagedObject {

    @FetchRequest var request : FetchedResults<T>


    let content : (T)->Content


    init(dateFileted : Date,@ViewBuilder content : @escaping(T) -> Content) {
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: dateFileted)
        
        let tommrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let fileterkey = "taskDate"
        
        let predict = NSPredicate(format: "\(fileterkey) >= %@ And \(fileterkey) < %@", argumentArray: [today,tommrow])
        
        
        


        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)],predicate: predict)

        self.content = content
    }


    var body: some View {
        Group{

            if request.isEmpty{

                Text("Not Task Found")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.black)
                    .offset(y: 200)



            }
         else{

                ForEach(request,id:\.objectID){object in

                    self.content(object)
                }
 }
        }
    }
}

