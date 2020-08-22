//
//  SignInView.swift
//  Pomodoro-SwiftUI-FB
//
//  Created by JD on 8/22/20.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
          Text("Thanks for using Pomodoro. Please sign in here")
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                    coordinator.startSignInWithAppleFlow {
                        //
                        print("You successfully Signed in")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignInView()
            SignInView()
        }
    }
}
