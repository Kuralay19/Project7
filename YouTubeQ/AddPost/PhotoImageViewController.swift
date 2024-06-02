//
//  PhotoImageViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 17.02.2024.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
class PhotoImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    lazy var selectedImageView = {
        let view = UIImageView()
       // view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
       // textView.placeholder = "Text here..."
        textView.textAlignment = .left
        textView.textColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    lazy var shareButton: UIButton = {
        let share = UIButton()
        share.backgroundColor = .blue
        share.setTitle("Share", for: .normal)
        share.translatesAutoresizingMaskIntoConstraints = false
        return share
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        shareButton.addTarget(self, action: #selector(handleUploadImage), for: .touchUpInside)
    }
    func setupLayouts() {
        view.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin)
            make.left.right.equalToSuperview()
            make.size.equalTo(280)
        }
        view.addSubview(commentTextView)
        commentTextView.snp.makeConstraints { make in
        
           make.top.equalTo(selectedImageView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.size.equalTo(60)
        }
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp_bottomMargin)
            make.size.equalTo(50)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    @objc func handleUploadImage() {
        guard let caption = commentTextView.text, caption.count > 0 else { return }
        guard let image = selectedImageView.image else { return }
        guard let uploadData = image.jpegData(compressionQuality: 0.3) else {return }
        navigationItem.rightBarButtonItem?.isEnabled = false
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(filename).putData(uploadData, metadata: nil) { (metadata, err)
        in
            if let err = err {
                print("Failed to upload post image",err )
               // self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("Successfully upload post image", err)
//            let imageUrl = Storage.storage().reference().child("Posts").child(filename)
        //    imageUrl.downloadURL { url, error in
            Storage.storage().reference().child("posts").child(filename).downloadURL { url, error in
                if let error = error {
                    print("Failed to downloadUrl", error)
                } else {
                    print("Successfully downloadURl ",url!)
                    let postImageUrl = url!.absoluteString
                    self.saveToDatabaseWithImageUrl(imageUrl: postImageUrl)
                }
                
            }
        }
    }
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    private func saveToDatabaseWithImageUrl(imageUrl: String) {
        guard let caption = commentTextView.text, caption.count > 0 else { return }
        guard let image = selectedImageView.image else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let randomPostId = UUID().uuidString
        let ref = userPostRef.child(randomPostId)
        let values = ["imageUrl": imageUrl,
                      "caption": caption,
                      "imageWidth": image.size.width,
                      "imageHeight": image.size.height,
                      "creationDate": Date().timeIntervalSince1970,
                      "id": randomPostId
        ] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to db", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("successfully saved post to db")
            self.dismiss(animated: true, completion: nil)
            self.tabBarController?.selectedIndex = 4
            NotificationCenter.default.post(name: PhotoImageViewController.updateFeedNotificationName, object: nil)
        }
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage =
            info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.selectedImageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectedImageView.image = originalImage
        }
       
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
        
    }

