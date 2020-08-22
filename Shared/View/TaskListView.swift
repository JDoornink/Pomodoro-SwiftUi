//
//  ContentView.swift
//  Shared
//
//  Created by JD on 7/5/20.
//

import SwiftUI

struct TaskListView: View {
    // @ObservedObject keyword allows SwiftUI to bind the UI by listening to any updates that this ViewModel is going to produce
    // This is the ViewModel for this View
    @ObservedObject var taskListVM = TaskListViewModel()
    let tasks = testDataTasks
    
    @State var presentAddNewItem = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                     }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task:Task (title: "", completed: false))) { task in
                            self.taskListVM.addTask(task:task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle()} ) {
                    HStack {
                        Image (systemName: "plus.circle.fill")
                            .frame(width: 20, height: 20)
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .navigationBarTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    // below, the "{ _ in } text is just provides a default implementation, the actual callback that 'onCommit' performs is handled above in the 'present new item' blockView
    var onCommit: (Task) -> (Void) = { _ in }
    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle" )
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}
