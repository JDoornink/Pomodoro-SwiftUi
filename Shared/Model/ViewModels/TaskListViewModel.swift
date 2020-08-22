//
//  TaskListViewModel.swift
//  Pomodoro-SwiftUI-FB
//
//  Created by JD on 7/5/20.
//

import Foundation
import Combine

// Wrapper around all the elements we are displaying in the list
class TaskListViewModel: ObservableObject {
    var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks
            .map { tasks in
                tasks.map { task in
                    TaskCellViewModel(task: task)
                }
            }
            .assign(to: \.taskCellViewModels, on: self)
            .store(in: &cancellables)
//        self.taskCellViewModels = testDataTasks.map { task in
//            TaskCellViewModel(task: task)
//        }
    }
    
    func addTask(task: Task) {
//        let taskVM = TaskCellViewModel(task: task)
//        self.taskCellViewModels.append(taskVM)
        taskRepository.addTask(task)
    }
}
