//
//  TaskRepository.swift
//  iOS
//
//  Created by JD on 7/13/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {

    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userId = Auth.auth().currentUser?.uid
        db.collection("tasks")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error ) in
            if let querySnapshot = querySnapshot {
                self.tasks = querySnapshot.documents.compactMap { document in
                    do {
                        let x = try document.data(as: Task.self)
                        return x
                    }
                    catch {
                        print(error)
                    }
                    return nil
                }
            }
            
        }
    }
    
    func addTask(_ task: Task) {
        do {
            var addedTask = task
            addedTask.userId = Auth.auth().currentUser?.uid
         let _ = try db.collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("unable to encode task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(_ task: Task){
        if let taskId = task.id {
            do {
                try db.collection("tasks").document(taskId).setData(from: task)
            }
            catch {
                fatalError("Unable to Encode task: \(error.localizedDescription)")
            }
        }
    }
}
