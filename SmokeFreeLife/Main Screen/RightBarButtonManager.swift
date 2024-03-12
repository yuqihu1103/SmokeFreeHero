//
//  RightBarButtonManager.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit
import FirebaseAuth

extension ViewController{
    func setupRightBarButton(isLoggedin: Bool){
        if isLoggedin{
            //MARK: if user is logged in, right bar button will be log out button
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogOutBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
            
        }else{
            //MARK: if user's not logged in, right bar button will be sign in button
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "person.fill.questionmark"),
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            let barText = UIBarButtonItem(
                title: "Sign in",
                style: .plain,
                target: self,
                action: #selector(onSignInBarButtonTapped)
            )
            
            navigationItem.rightBarButtonItems = [barIcon, barText]
        }
    }
    
    //MARK: handle sign in
    @objc func onSignInBarButtonTapped(){
        //MARK: set up the title and message of the alert controller
        let signInAlert = UIAlertController(
            title: "Sign In / Register",
            message: "Please sign in to continue. If you don't have an account, register first.",
            preferredStyle: .alert)
        
        //MARK: Sign In Action...
        let signInAction = UIAlertAction(title: "Sign In", style: .default, handler: {(_) in
            //MARK: logic to open the sign in screen...
            let signInViewController = SignInScreenViewController()
            self.navigationController?.pushViewController(signInViewController, animated: true)
        })
        
        //MARK: Register Action...
        let registerAction = UIAlertAction(title: "Register", style: .default, handler: {(_) in
            //MARK: logic to open the register screen...
            let registerViewController = RegisterScreenViewController()
            self.navigationController?.pushViewController(registerViewController, animated: true)
        })
        
        //MARK: action buttons... user choose to sign in with email and password or to register
        signInAlert.addAction(signInAction)
        signInAlert.addAction(registerAction)
        
        //MARK: present the alert
        self.present(signInAlert, animated: true, completion: {() in
            //MARK: hide the alert if user tap outside...
            signInAlert.view.superview?.isUserInteractionEnabled = true
            signInAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    @objc func onTapOutsideAlert(){
        //MARK: dismiss the alert if user tapped outside
        self.dismiss(animated: true)
    }
    
    //MARK: handle log out
    @objc func onLogOutBarButtonTapped(){
        //MARK: setup the alert
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        
        //MARK: log user out with Firebase Authentication if user tap "Log out!"
        logoutAlert.addAction(UIAlertAction(title: "Log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                }catch{
                    print("Error occured!")
                }
            })
        )
        
        //MARK: user stays logged in if tap "Cancel"
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        //MARK: present the alert
        self.present(logoutAlert, animated: true)
    }
    
}
