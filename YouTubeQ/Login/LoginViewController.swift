//
//  Login.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 13.01.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
class LoginViewController: UIViewController {
    
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
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
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Log in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Sign up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayouts()
        setupTextFields()
        
    }
    func setupLayouts() {
        view.addSubview(uploadPhotoButton)
        uploadPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(50)
            make.left.right.equalToSuperview().offset(-30)
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
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passTextField.snp.bottom).offset(30)
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
        loginTextField.addTarget(self, action: #selector(handleTextAdded), for: .allEditingEvents)
        passTextField.addTarget(self, action: #selector(handlePassTextAdded), for: .allEditingEvents)
        signupButton.addTarget(self, action: #selector(handleSignUpPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(handleSignInPressed), for: .touchUpInside)
    }
    @objc func handleTextAdded(_ textField: UITextField) {
        print("logintext :\(textField.text)")
    }
    @objc func handlePassTextAdded(_ textField: UITextField) {
        print("passtext :\(textField.text)")
    }
    @objc func handleSignInPressed() {
        guard let login = loginTextField.text, login.count > 0 else { return }
        guard let pass = passTextField.text, pass.count > 0 else { return }
        
        Auth.auth().signIn(withEmail: login,password: pass) { res, err in
            if let err = err {
                print ("error\(err)")
                return
            }
            if let res = res {
//                let feedViewController = ViewController(collectionViewLayout: UICollectionViewFlowLayout())
//                self.navigationController?.pushViewController(feedViewController, animated: true)
                self.dismiss(animated: true)
            }
        }
        
    }
    @objc func handleSignUpPressed() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
