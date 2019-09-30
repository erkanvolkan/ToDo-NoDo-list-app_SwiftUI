//
//  ContentView.swift
//  ActivityLog
//
//  Created by Erkan on 9/29/19.
//  Copyright © 2019 Erkan. All rights reserved.
//exp

import SwiftUI

struct ContentView: View {
    @State var nodo: String = ""
    @State var nodoList = [String]()
    @State var timeAgo: String = ""
    
    @State var todo: String = ""
    @State var todoList = [String]()
    @State var toggleChoose = true

    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
//                    Text("Not To Do")
//                        .padding(12)
//                        .onTapGesture {
//                            self.toggleChoose = false
//                    }
//                    Toggle("",isOn: $toggleChoose)
                    Picker(selection: $toggleChoose,label: Text("LOG")){
                        Text("Not To Do").tag(false)
                        Text("To Do").tag(true)
                    }.pickerStyle(SegmentedPickerStyle())
                    //                    Spacer()
//                    Text("To Do")
//                        .padding(12)
//                        .onTapGesture {
//                            self.toggleChoose = true
//                    }
            
                }
                
                if toggleChoose == false{
                    TextField("what will you NOT do today !", text:self.$nodo, onEditingChanged: {
                        (changed) in
                        print(changed)
                        
                    }){
                        self.timeAgo = self.timeAgoSinceDate(Date())
                        self.nodoList.insert(self.nodo, at: 0)
                        self.nodo = ""
                        
                        //print("oncommit time")
                    }.padding(.all,12)
                        .background(Color.white)
                        .foregroundColor(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                        .padding(.trailing,8)
                    List{
                        ForEach(self.nodoList, id: \.self){ item in
                            NoDoRow(noDoItem: item, timeAgo: self.timeAgo)
                        }.onDelete(perform: deleteItem)
                    }
             
                }; if toggleChoose == true {
                    TextField("what will you do today !", text:self.$todo, onEditingChanged: {
                        (changed) in
                        print(changed)
                        
                    }){
                        self.timeAgo = self.timeAgoSinceDate(Date())
                        self.todoList.insert(self.todo, at: 0)
                        self.todo = ""
                        
                        //print("oncommit time")
                    }.padding(.all,12)
                        .background(Color.green)
                        .foregroundColor(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 5)
                        .padding(.trailing,8)
                    
                    List{
                        ForEach(self.todoList, id: \.self){ item in
                            ToDoRow(toDoItem: item, timeAgo: self.timeAgo)
                        }
                        .onDelete(perform: deleteItemtodo)
                    }
                    
                }
                
                
            }.navigationBarTitle("Activity_LOG")
        }
    }
    
    
    
    
    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String{
        let calender = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calender.dateComponents(unitFlags, from: earliest, to: latest)
        
        if (components.year! >= 2){
            return "\(components.year!) years ago"
        }else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            }else {
                return "Last Year"
            }
        }else if(components.month! >= 2){
            return "\(components.month!) months ago"
        }else if(components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            }else {
                return "Last Month"
            }
        }else if(components.weekOfYear! >= 2){
            return "\(components.weekOfYear!) weeks ago"
        }else if(components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            }else {
                return "Last week"
            }
            
        }else if(components.day! >= 2){
            return "\(components.day!) days ago"
        }else if(components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            }else {
                return "yesterday"
            }
        }else if(components.hour! >= 2){
            return "\(components.hour!) hours ago"
        }else if(components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            }else {
                return "an hour ago"
            }
        }else if(components.minute! >= 2){
            return "\(components.minute!) minutes ago"
        }else if(components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            }else {
                return "a minute ago"
            }
        }else if(components.second! >= 3){
            return "\(components.second!) seconds ago"
        }else {
            return "Just now"
        }
    }
    func deleteItem(at offsets: IndexSet){
        guard let index = Array (offsets).first else {return}
        print("remove: \(self.nodoList[index])")
        self.nodoList.remove(at: index)
    }
    func deleteItemtodo(at offsets: IndexSet){
        guard let index = Array (offsets).first else {return}
        print("remove: \(self.todoList[index])")
        self.todoList.remove(at: index)
    }
    
    
}


struct NoDoRow: View{
    @State var noDoItem: String = ""
    @State var isDone = false
    @State var timeAgo: String
    
    
    //    @State var noDoList: [String]()
    var body: some View{
        VStack(alignment: .center, spacing: 2){
            Group{
                HStack{
                    Text(noDoItem)
                        .padding()
                        .foregroundColor((self.isDone) ? .white : .black)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    Image(systemName: (self.isDone) ? "checkmark" : "square")
                        .padding()
                    
                }
                HStack(alignment: .center, spacing: 3){
                    Spacer()
                    Text("Added : \(self.timeAgo)")
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all,4)
                }.padding(.bottom,5)
                
            }.padding(.all,4)
            
        }
        .background((self.isDone) ? Color.gray : Color.pink)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .onTapGesture {
            self.isDone.toggle()
            print("tappe")
        }
    }
}

struct ToDoRow: View{
    @State var toDoItem: String = ""
   @State var isDone = false
    @State var timeAgo: String
    
    
    //    @State var noDoList: [String]()
    var body: some View{
        VStack(alignment: .center, spacing: 2){
            Group{
                HStack{
                    Text(toDoItem)
                        .padding()
                        .foregroundColor((self.isDone) ? .white : .black)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    Image(systemName: (self.isDone) ? "checkmark" : "square")
                        .padding()
                    
                }
                HStack(alignment: .center, spacing: 3){
                    Spacer()
                    Text("Added : \(self.timeAgo)")
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all,4)
                }.padding(.bottom,5)
                
            }.padding(.all,4)
            
        }
        .background((self.isDone) ? Color.green : Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 7))
        .onTapGesture {
            self.isDone.toggle()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
