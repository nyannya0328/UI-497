//
//  Home.swift
//  UI-497
//
//  Created by nyannyan0328 on 2022/03/07.
//

import SwiftUI

struct Home: View {
    @StateObject var model = TaskViewModel()
    
    @Namespace var animation
    
    @Environment(\.editMode) var editButton
    
    @Environment(\.managedObjectContext) var context
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            
            Section {
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    
                    LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                        
                        
                        HStack(spacing:10){
                            
                            
                            ForEach(model.currentWeek,id:\.self){day in
                                
                                
                                
                                VStack(spacing:10){
                                    
                                    Text(model.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15, weight: .semibold))
                                    
                                    Text(model.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 15, weight: .semibold))
                                    
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(model.isToday(date: day) ? 1 : 0)
                                    
                                }
                            
                                .foregroundStyle(model.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(model.isToday(date: day) ? .white : .black)
                                
                                .frame(width: 45, height: 90)
                                .background{
                                    
                                    
                                    ZStack{
                                        
                                        
                                        
                                        if model.isToday(date: day){
                                            
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                    
                                    
                                    
                                    
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    
                                    
                                    model.currentDay = day
                                }
                               
                                
                                
                            }
                            
                        }
                        .padding(.horizontal)
                        
                    }
                    
                    
                }
                
                
        TaskView()
                
                
                
                
            } header: {
                
                
                HeaderView()
                
                
            }

            
            
            
            
            
        }
        .ignoresSafeArea(.container, edges: .top)
        .overlay(alignment: .bottomTrailing) {
            
            Button {
                withAnimation{
                    
                    model.addNewTask.toggle()
                }
            } label: {
                
                
                Image(systemName: "plus")
                    .font(.title)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(.black,in: Circle())
            }
            .padding(.trailing,10)

            
        }
        .sheet(isPresented: $model.addNewTask, onDismiss: {
            
            model.editeTask = nil
            
        }, content: {
            NewTaskView()
                .environmentObject(model)
            
        })
      
    }
    
    @ViewBuilder
    func HeaderView()->some View{
        
        
        HStack{
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.gray)
                
                
                
                Text("Today")
                    .font(.largeTitle.weight(.bold))
                
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            EditButton()
            
        }
        .padding()

        .padding(.top,getSafeArea().top)
        .background(.white)
        
        
        
    }
    
    @ViewBuilder
    func TaskView()->some View{
        
        LazyVStack(spacing:15){
            
            
            DynamicFileterView(dateFileted: model.currentDay) { (object : Task) in
                
                TaskCardView(task: object)
                
            }
        }
        
    
    }
    
    @ViewBuilder
    func TaskCardView(task : Task) -> some View{
        
        
        HStack(alignment: editButton?.wrappedValue == .active ? .center : .top, spacing: 10) {
            
            
            VStack(spacing:10){
                
                
                HStack(alignment: editButton?.wrappedValue == .active ? .center : .top) {
                    
                    
                    if editButton?.wrappedValue == .active{
                        
                        
                        VStack{
                            
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                
                            }
                            
                            
                            Button {
                                
                                context.delete(task)
                        
                                
                            } label: {
                                
                                Image(systemName: "minus.circle.fill")
                                
                                
                            }
                            
                            
                            

                            
                        }
                        
                        
                    }
                    
                    else{
                        
                        Circle()
                            .fill(model.isCurrentHour(date: task.taskDate ?? Date()) ? (task.isCompleted ? .green : .black) : .clear)
                            .background(Circle().stroke(.black,lineWidth: 1).padding(-3))
                            .scaleEffect(!model.isCurrentHour(date: task.taskDate ?? Date()) ? 0.8 : 1)
                        
                        
                        
                        Rectangle()
                            .fill(.black)
                            .frame(width: 3)
                        
                        
                    }
                    
                    
                    
                }
                
                
             
            }
            
            
            VStack{
                
                
                HStack(alignment: .top, spacing: 13) {
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(task.taskTitle ?? "")
                        
                        Text(task.taskDescription ?? "")
                        
                        
                    }
                    
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Text(task.taskDate?.formatted(date: .numeric, time: .omitted) ?? "")
                    
                    
                    
                    
                }
                
                
                
                if model.isCurrentHour(date: task.taskDate ?? Date()){
                    
                    
                    HStack(spacing:13){
                        
                        if !task.isCompleted{
                            
                            Button {
                                
                                task.isCompleted = true
                                try? context.save()
                                
                            } label: {
                                
                                
                                Image(systemName: "check.mark")
                                
                                
                            }

                            
                            
                        }
                        
                        Text(task.isCompleted ? "Mark as Completed" : "Mark Task as completed")
                            .font(.system(size: task.isCompleted ? 13 : 16, weight: .light))
                            .foregroundColor(task.isCompleted ? .gray : .white)
                            .frame(maxWidth:.infinity,alignment: .leading)
                            
                        
                        
                    }
                    
                    
                }
                
                
                
            }
            .foregroundColor(model.isCurrentHour(date: task.taskDate ?? Date()) ? .white : .black)
            .padding(model.isCurrentHour(date: task.taskDate ?? Date()) ? 15 : 0)
            .background(Color("Black"))
            .cornerRadius(20)
            .frame(maxWidth:.infinity,alignment: .leading)
            .opacity(model.isCurrentHour(date: Date()) ? 1 : 0)
          
            
            
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

func getSafeArea()->UIEdgeInsets{
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
        return .zero
    }
    
    guard let safeArea = screen.windows.first?.safeAreaInsets else{
        return .zero
    }
    
    return safeArea
}
