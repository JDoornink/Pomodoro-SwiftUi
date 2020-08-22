//
//  Task.swift
//  iOS
//
//  Created by JD on 7/5/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Task: Identifiable, Codable {
    //automatically assigns a unique Id to each test item
    @DocumentID var id: String?
    var title: String
    var completed: Bool
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}

#if DEBUG
let testDataTasks = [
    Task(title: "Implemente the UI", completed: true),
    Task(title: "Connect to Firebase", completed: false),
    Task(title: "????", completed: false),
    Task(title: "Profit!!!", completed: false)
]
#endif

