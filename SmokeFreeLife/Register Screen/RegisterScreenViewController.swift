//
//  RegisterScreenViewController.swift
//  SmokeFreeLife
//
//  Created by Yuqi Hu on 12/3/23.
//

import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class RegisterScreenViewController: UIViewController {

    let registerView = RegisterScreenView()
    
    //for profile image
    var pickedImage:UIImage?
    let storage = Storage.storage()
    
    override func loadView() {
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: set up title
        title = "Register"
        
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        
        registerView.buttonTakePhoto.menu = getMenuImagePicker()

    }
    
    //MARK: handle register
    @objc func onRegisterTapped(){
        //MARK: validate that name is not empty
        guard let name = registerView.textFieldName.text, !name.isEmpty else {
            //MARK: Show an alert indicating that the name is empty
            showAlert(message: "Please enter your name.")
            return
        }
        
        //MARK: validate that email is not empty and is correctly formatted
        guard let email = registerView.textFieldEmail.text, !email.isEmpty else {
            //MARK: Show an alert indicating that the email is empty or not in a valid format
            showAlert(message: "Please enter a email.")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "Email format invalid.")
            return
        }
        
        //MARK: validate that password is not empty
        guard let password = registerView.textFieldPassword.text, !password.isEmpty else {
            //MARK: Show an alert indicating that the password is empty
            showAlert(message: "Please enter your password.")
            return
        }
        
        //MARK: validate that repeat password is not empty and passwords match
        guard let repeatPassword = registerView.textFieldRepeatPassword.text, !repeatPassword.isEmpty else {
            //MARK: Show an alert indicating that the password is empty
            showAlert(message: "Please re-enter your password.")
            return
        }
        
        if password != repeatPassword {
            showAlert(message: "Passwords must match.")
            return
        }
        
        guard let numCigarettesText = registerView.textFieldNumCigarettes.text,
                  let amountMoneyText = registerView.textFieldAmountMoney.text,
                  let numCigarettes = Int(numCigarettesText),
                  let amountMoney = Double(amountMoneyText),
                  numCigarettes >= 0,
                  amountMoney >= 0 else {
                      showAlert(message: "Please enter valid values for cigarettes and money.")
                      return
                  }
        
        guard pickedImage != nil else {
                showAlert(message: "Please select a profile photo.")
                return
            }
        
        registerView.activityIndicator.startAnimating()
        
        //MARK: creating a new user on Firebase...
        self.registerNewAccount(name: name, email: email, password: password, numCigarettes: numCigarettes, amountMoney: amountMoney)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Stop activity indicator after registration completion
            self.registerView.activityIndicator.stopAnimating()
        }
    }
    
    //MARK: Helper method to validate a email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: Helper method to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: menu for buttonTakePhoto setup...
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        //MARK: Photo from Gallery...
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func showRegistrationCompleteAlert() {
            let alert = UIAlertController(title: "Success", message: "Registration completed!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
}


//MARK: adopting required protocols for PHPicker...
extension RegisterScreenViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(
                    ofClass: UIImage.self,
                    completionHandler: { (image, error) in
                        DispatchQueue.main.async{
                            if let uwImage = image as? UIImage{
                                self.registerView.buttonTakePhoto.setImage(
                                    uwImage.withRenderingMode(.alwaysOriginal),
                                    for: .normal
                                )
                                self.pickedImage = uwImage
                            }
                        }
                    }
                )
            }
        }
    }
}

//MARK: adopting required protocols for UIImagePicker...
extension RegisterScreenViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.registerView.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
            showAlert(message: "No image loaded.")
        }
    }
}

