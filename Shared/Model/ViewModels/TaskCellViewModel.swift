//
//  TaskCellViewModel.swift
//  Pomodoro-SwiftUI-FB
//
//  Created by JD on 7/5/20.
//

import Foundation
import Combine

// Making this an ObservableObject allows SwiftUI to observe any changes to the properties we make on this ViewModel
// Identifiable is necessary because we want to use these items in a List view which requires items be Identifiable
class  TaskCellViewModel: ObservableObject, Identifiable {
    //@PUblished keyword makes this property listened to (ie a publisher)
    @Published var task: Task
    @Published var taskRepository = TaskRepository()
    
    var id = ""
    @Published var completionStateIconName = ""
    // Description of cancellables =  https://www.youtube.com/watch?v=4RUeW5rUcww: Time 30:00 -> 30:32
    private var cancellables = Set<AnyCancellable>()
    
    // Initializer takes a task, and the operates on the task
    init(task: Task) {
        // keeps track of the task
        self.task = task
        
        $task
            //.map gets the string version of a task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            //below assigns the value tothe property completionStateIconName 
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            // skips any updates that might happen due to the programmer making changes
            .dropFirst()
            // waits to send changes for 0.8 seconds after you stop typing
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
        }
}
