//
//  ViewController.swift
//  SmokeFreeLife
//
//  Created by XuanShichun on 11/19/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    //MARK: Create an authentication state change listener to track whether any user is signed in.
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    //MARK: Create a variable to keep an instance of the current signed-in Firebase user.
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = mainScreen
    }
    
    //MARK: This method is called just before the view controller's view is about to be added to the view hierarchy. Tasks in it are performed before the view becomes visible
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        //MARK: Automatically called each time user logs in/out
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in first!"
                
                //MARK: To do: Disable/hide other functionalities and reset chats
                self.mainScreen.buttonForum.isHidden = true
                
                //MARK: show sign in button
                self.setupRightBarButton(isLoggedin: false)
                
                //MARK: set up title
                self.title = "Smoke Free Hero"
                
            }else{
                //MARK: the user is signed in...
                self.currentUser = user
                self.mainScreen.labelText.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                
                //MARK: To do: Enable/show other functionalities and load chats
                self.mainScreen.buttonForum.isHidden = false
                
                //MARK: show log out button
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: set up title
                self.title = "Dashboard"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: This method is called just before the view controller's view is about to be removed from the view hierarchy, we remove the listener here from the app so that we do not run the listener infinitely.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

}
