//
//  ViewController.swift
//  SmokeFreeLife
//
//  Created by XuanShichun on 11/19/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    let notificationCenter = NotificationCenter.default
    
    //MARK: Create an authentication state change listener to track whether any user is signed in.
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    //MARK: Create a variable to keep an instance of the current signed-in Firebase user.
    var currentUser:FirebaseAuth.User?
    
    var timer: Timer?
    
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
                self.mainScreen.buttonProfile.isHidden = true
                self.mainScreen.labelSmokeFreeTime.isHidden = true
                self.mainScreen.labelCigSaved.isHidden = true
                self.mainScreen.labelMoneySaved.isHidden = true
                self.mainScreen.buttonSetStartPoint.isHidden = true
                
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
                self.mainScreen.buttonProfile.isHidden = false
                self.mainScreen.labelSmokeFreeTime.isHidden = false
                self.mainScreen.labelCigSaved.isHidden = false
                self.mainScreen.labelMoneySaved.isHidden = false
                self.mainScreen.buttonSetStartPoint.isHidden = false
                
                //MARK: show log out button
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: set up title
                self.title = "Dashboard"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreen.buttonForum.addTarget(self, action: #selector(onButtonForumTapped), for: .touchUpInside)
        mainScreen.buttonProfile.addTarget(self, action: #selector(onButtonProfileTapped), for: .touchUpInside)
        
        mainScreen.buttonSetStartPoint.addTarget(self, action: #selector(setStartPointTapped), for: .touchUpInside)
        
        //MARK: observing text if it is updated in NotificationCenter...
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("infoEdited"),
            object: nil)
        
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceivedForTextChanged(notification:)),
            name: Notification.Name("userChanged"),
            object: nil)
        
        fetchSmokingInfo()
        scheduleDailyFetch()
    }
    
    //MARK: This method is called just before the view controller's view is about to be removed from the view hierarchy, we remove the listener here from the app so that we do not run the listener infinitely.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func onButtonForumTapped(){
        let ForumScreen = ForumScreenViewController()
        
        if let user = self.currentUser{
            ForumScreen.currentUserName = user.displayName
        }
        navigationController?.pushViewController(ForumScreen, animated: true)
    }
    
    @objc func onButtonProfileTapped(){
        let profileScreen = ProfileScreenViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
        self.fetchSmokingInfo()
    }

    func fetchSmokingInfo() {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        Firestore.firestore().collection("Users")
            .document(currentUser.uid)
            .getDocument { [weak self] (snapshot, error) in
                guard let self = self, let snapshot = snapshot else { return }
                print(snapshot.data() as Any)
                
                if let data = snapshot.data(),
                   let lastSmokeTimestamp = data["lastSmokeTime"] as? TimeInterval,
                   let avgCigsPerDay = data["numCigarettes"] as? Int,
                   let avgMoneyPerDay = data["amountMoney"] as? Double {
                    
                    // Calculate time since last smoke in days
                    let currentDate = Date().timeIntervalSince1970
                    let timeSinceLastSmoke = currentDate - lastSmokeTimestamp
                    let daysSinceLastSmoke = Int(timeSinceLastSmoke / (60 * 60 * 24))
                    
                    // Calculate cigs saved and money saved since stopped smoking
                    let cigsSaved = daysSinceLastSmoke * avgCigsPerDay
                    let moneySaved = Double(daysSinceLastSmoke) * avgMoneyPerDay
                    
                    DispatchQueue.main.async {
                        // Update UI elements
                        self.mainScreen.labelSmokeFreeTime.text = "Smoke Free for \(daysSinceLastSmoke) day(s)"
                        self.mainScreen.labelCigSaved.text = "Cigarettes Saved: \(cigsSaved)"
                        self.mainScreen.labelMoneySaved.text = String(format: "Money Saved: $%.2f", moneySaved)
                        self.mainScreen.buttonSetStartPoint.setTitle("I smoked. Start over.", for: .normal)
                    }
                } else {
                    // User has not set the last smoke time, prompt to start recording
                    DispatchQueue.main.async {
                        self.mainScreen.labelSmokeFreeTime.text = "Record Smoke-Free Time Now"
                        self.mainScreen.labelCigSaved.text = "Cigarettes Saved: 0"
                        self.mainScreen.labelMoneySaved.text = "Money Saved: $0.00"
                        self.mainScreen.buttonSetStartPoint.setTitle("Set Start Point", for: .normal)
                    }
                }
        }
    }

    
    @objc func setStartPointTapped() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User not logged in.")
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let db = Firestore.firestore()
        
        db.collection("Users").document(currentUser.uid).setData(["lastSmokeTime": timestamp], merge: true) { error in
            if let error = error {
                print("Error setting last smoke time: \(error.localizedDescription)")
            } else {
                print("Last smoke time set successfully!")
                self.fetchSmokingInfo()
            }
        }
    }

    func scheduleDailyFetch() {
        // Set up a repeating timer to fire every 24 hours (86400 seconds)
        timer = Timer.scheduledTimer(timeInterval: 86400, target: self, selector: #selector(fetchDailySmokingInfo), userInfo: nil, repeats: true)
    }
    
    @objc func fetchDailySmokingInfo() {
        // Fetch smoking info
        fetchSmokingInfo()
    }
    
    // Remember to invalidate the timer when the view controller is deallocated or not needed anymore
    deinit {
        timer?.invalidate()
    }
    
}
