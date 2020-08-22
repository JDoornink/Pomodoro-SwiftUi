//
//  Pomodoro_SwiftUI_FBApp.swift
//  Shared
//
//  Created by JD on 7/5/20.
//

import SwiftUI
import Firebase

@main
struct SO62626652_InitialiserApp: App {
  
  init() {
    FirebaseApp.configure()
    Auth.auth().signInAnonymously()
  }
  
  var body: some Scene {
    WindowGroup {
      TaskListView()
    }
  }
}
