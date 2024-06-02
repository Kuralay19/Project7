//
//  SignUpViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 20.01.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class SignUpViewController: UIViewController {
 
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus_photo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
  
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone number or email adress"
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var passTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passRepeatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Repeat your  password"
        textField.textColor = .black
        textField.backgroundColor = .lightGray
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red.withAlphaComponent(0.5)
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        setupTextFields()
        
    }
    func setupLayouts() {
       view.addSubview(uploadPhotoButton)
        uploadPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(50)
            make.centerX.equalToSuperview()
            make.size.equalTo(140)
        }
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(uploadPhotoButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        view.addSubview(passTextField)
        passTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
            
        }
        
        view.addSubview(passRepeatTextField)
        passRepeatTextField.snp.makeConstraints { make in
            make.top.equalTo(passTextField.snp.bottom).offset(10) //offset(-), inset(+)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
            
        }
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50) //offset(-), inset(+)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
            
        }
    }
    func setupTextFields() {
        uploadPhotoButton.addTarget(self, action: #selector(uploadPhotoPressed), for: .touchUpInside)
        loginTextField.addTarget(self, action: #selector(handleTextAdded), for: .allEditingEvents)
        passTextField.addTarget(self, action: #selector(handlePassTextAdded), for: .allEditingEvents)
        signupButton.addTarget(self, action: #selector(handleSignInPressed), for: .touchUpInside)
    }
    @objc func uploadPhotoPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
    }
   
    @objc func handleTextAdded(_ textField: UITextField) {
        print("logintext :\(textField.text)")
    }
    var isValidPass: Bool = false
    @objc func handlePassTextAdded(_ textField: UITextField) {
        guard
            let pass1 = passTextField.text, pass1.count > 0,
            let pass2 = passRepeatTextField.text, pass2.count > 0
        else { return }
        if pass1 == pass2 {
            isValidPass = true
            signupButton.isEnabled = true
            signupButton.backgroundColor = .red.withAlphaComponent(0.5)
        }
    }
 
    @objc func handleSignInPressed() {
        guard let login = loginTextField.text, login.count > 0 else { return }
        guard let pass = passTextField.text, pass.count > 0 else { return }
        Auth.auth().createUser(withEmail: login, password: pass) {res, err in
            if let err = err {
                print("auth err :\(err)")
                return
            }
            if let res = res {
                print("result: \(res)")
                if let uploadImageData = self.uploadPhotoButton.imageView?.image?.jpegData(compressionQuality: 0.3) {
                    let filename = NSUUID().uuidString
                    Storage.storage().reference().child("profile_images").child(filename).putData(uploadImageData, metadata: nil) { metadata, err in
                        if let err = err {
                            print("error upload profile image \(err)")
                            return
                        }
                        Storage.storage().reference().child("profile_images").child(filename).downloadURL { url, err in
                            if let err = err {
                                print("err downloadURL: \(err)")
                                return
                            }
                            let profileImageUrl = url!.absoluteString
                            let uid = res.user.uid
                            let dicitionaryValues = ["username": login, "profileImageUrl": profileImageUrl] as [String: Any]
                            let values =  [uid: dicitionaryValues]
                            Database.database().reference().child("users").updateChildValues(values) { err, res in
                                if let err = err {
                                    print("Failed to save user info in db:", err)
                                    return
                                }
                                print("Sucessfully saved users info in db")
                                self.dismiss(animated: true)
//                                let feedViewController = ViewController(collectionViewLayout: UICollectionViewFlowLayout())
//                                self.navigationController?.pushViewController(feedViewController, animated: true)
                            }
                        }
                        
                    }
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            }
        }
        
    }
    
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("imageInfo \(info)")
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            uploadPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            uploadPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        uploadPhotoButton.layer.cornerRadius = uploadPhotoButton.frame.width / 2
        uploadPhotoButton.layer.masksToBounds = true
        uploadPhotoButton.layer.borderColor = UIColor.red.cgColor
        uploadPhotoButton.layer.borderWidth = 3
        dismiss(animated: true)
    }
    
}


/*import SwiftUI
@available(iOS 13.0,  *)
struct MainVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        }
        
        let mainVC = LoginViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>)
        -> LoginViewController {
            return mainVC
        }
    }
}
*/

