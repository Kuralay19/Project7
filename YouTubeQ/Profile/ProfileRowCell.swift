//
//  ProfileRowCell.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 03.02.2024.
//

import UIKit
import SnapKit
class ProfileRowCell: UICollectionViewCell {
    lazy var loginView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var account_name: UILabel = {
        let label = UILabel()
        label.text = "ospanov_go"
        label.textColor = .black
       label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"add1")?.withRenderingMode(.alwaysOriginal),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named:"settings")?.withRenderingMode(.alwaysOriginal),for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var infoView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var profile_photo : UIImageView = {
        let profile_photo = UIImageView()
        profile_photo.contentMode = .scaleAspectFill
        profile_photo.layer.cornerRadius = 40
        profile_photo.image = UIImage(named: "fl2")?.withRenderingMode(.alwaysOriginal)
        //  profile_photo.backgroundColor = .yellow
        profile_photo.translatesAutoresizingMaskIntoConstraints = false
        return profile_photo
    }()
    lazy var postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("15", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var postLabel: UILabel = {
        let label = UILabel()
        label.text = "posts"
        label.textAlignment = .center
        label.textColor = .black
       label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("20", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "followers"
        label.textAlignment = .center
        label.textColor = .black
       label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("20", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "following"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        lazy var detailView = {
            let view = UIView()
            view.backgroundColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        lazy var infoLabel: UILabel = {
            let label = UILabel()
            label.text = """
                Blog about flowers
                        Blog about flowers
                        Blog about flowers
            """
    
            label.textColor = .black
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.numberOfLines = 4
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var additionalView = {
            let view = UIView()
            view.backgroundColor = .purple
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        lazy var editProfile: UIButton = {
            let button = UIButton()
            button.setTitle("Edit profile", for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        lazy var shareProfile: UIButton = {
            let button = UIButton()
            button.setTitle("Share profile", for: .normal)
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        lazy var others: UIButton = {
            let button = UIButton()
            button.backgroundColor = .lightGray
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        lazy var highlightsView = {
            let view = UIView()
            view.backgroundColor = .purple
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        lazy var highlights: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 35
            imageView.backgroundColor = .blue
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        lazy var highlightsText: UILabel = {
          let label = UILabel()
            label.text = "highlights"
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    func setupLayouts() {
        addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        loginView.addSubview(account_name)
        account_name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-11)
        }
        loginView.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(24)
        }
        
        loginView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalTo(settingsButton.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-8)
            make.size.equalTo(24)
            
        }
        
        addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(-5)
            make.left.right.equalToSuperview()
            make.size.equalTo(90)
        }
        infoView.addSubview(profile_photo)
        profile_photo.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(1)
            make.left.equalToSuperview().offset(12)
            make.size.equalTo(80)
        }
        let infoButtonStackView = UIStackView(arrangedSubviews: [ postsButton, followersButton, followingButton])
        infoButtonStackView.axis = .horizontal
        //infoButtonStackView.backgroundColor = .black
        infoButtonStackView.spacing = 20
        infoButtonStackView.distribution = .fillEqually
        infoView.addSubview(infoButtonStackView)
        infoButtonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(profile_photo.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
        let infoLabelStackView = UIStackView(arrangedSubviews: [ postLabel, followersLabel, followingLabel])
        //infoLabelStackView.backgroundColor = .black
        infoLabelStackView.axis = .horizontal
        infoLabelStackView.spacing = 20
        infoLabelStackView.distribution = .fillEqually
        infoView.addSubview(infoLabelStackView)
        infoLabelStackView.snp.makeConstraints { make in
           // make.centerY.equalToSuperview()
            make.top.equalTo(infoButtonStackView.snp.bottom).offset(5)
            make.left.equalTo(profile_photo.snp.right).offset(20)
            make.right.equalToSuperview().inset(20)
        }
            //        infoView.addSubview(followingButton)
            //        followingButton.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(15)
            //            make.right.equalToSuperview().offset(-30)
            //            make.size.equalTo(40)
            //
            //        }
            //        infoView.addSubview(followingLabel)
            //        followingLabel.snp.makeConstraints { make in
            //            make.top.equalTo(followingButton.snp.bottom).offset(3)
            //            make.right.equalToSuperview().offset(-30)
            //        }
            //        infoView.addSubview(followersButton)
            //        followersButton.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(15)
            //            make.right.equalTo(followingButton.snp.left).offset(-30)
            //            make.size.equalTo(40)
            //
            //        }
            //        infoView.addSubview(followersLabel)
            //        followersLabel.snp.makeConstraints { make in
            //            make.top.equalTo(followersButton.snp.bottom).offset(3)
            //            make.right.equalTo(followingLabel.snp.left).offset(-25)
            //        }
            //
            //       infoView.addSubview(postsButton)
            //        postsButton.snp.makeConstraints { make in
            //            make.top.equalToSuperview().offset(15)
            //            make.right.equalTo(followersButton.snp.left).offset(-30)
            //            make.size.equalTo(40)
            //
            //        }
            //        infoView.addSubview(postLabel)
            //        postLabel.snp.makeConstraints { make in
            //            make.top.equalTo(postsButton.snp.bottom).offset(3)
            //            make.right.equalTo(followersLabel.snp.left).offset(-30)
            //        }
            //
            
                    addSubview(detailView)
                    detailView.snp.makeConstraints { make in
                        make.top.equalTo(infoView.snp.bottom).offset(1)
                        make.left.right.equalToSuperview()
            
                    }
                    detailView.addSubview(infoLabel)
                    infoLabel.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(5)
                        make.left.equalToSuperview().offset(12)
                        make.bottom.equalToSuperview().offset(-5)
            
                    }
                    addSubview(additionalView)
                    additionalView.snp.makeConstraints { make in
                        make.top.equalTo(detailView.snp.bottom).offset(0.5)
                        make.left.right.equalToSuperview()
                        make.size.equalTo(60)
                    }
                    additionalView.addSubview(editProfile)
                    editProfile.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(15)
                        make.left.equalToSuperview().offset(12)
                        make.width.equalTo(165)
                        make.height.equalTo(25)
            
                    }
                    additionalView.addSubview(shareProfile)
                    shareProfile.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(15)
                        make.left.equalTo(editProfile.snp.right).offset(10)
                        make.width.equalTo(165)
                        make.height.equalTo(25)
            
            
                    }
                    additionalView.addSubview(others)
                    others.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(15)
                        make.left.equalTo(shareProfile.snp.right).offset(10)
                        make.size.equalTo(25)
                    }
                   addSubview(highlightsView)
                    highlightsView.snp.makeConstraints { make in
                        make.top.equalTo(additionalView.snp.bottom).offset(0.5)
                        make.left.right.equalToSuperview()
                        make.size.equalTo(107)
                    }
                    highlightsView.addSubview(highlights)
                    highlights.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(1)
                        make.left.equalToSuperview().offset(12)
                        make.size.equalTo(70)
                    }
                    highlights.addSubview(highlightsText)
                    highlightsText.snp.makeConstraints { make in
                        make.top.equalTo(highlights.snp.bottom).offset(3)
                    }
            /*    addSubview(postsView)
             postsView.snp.makeConstraints { make in
             make.top.equalTo(highlightsView.snp.bottom).offset(1)
             make.left.right.equalToSuperview()
             make.size.equalTo(370)
             }
             postsView.addSubview(firstPost)
             firstPost.snp.makeConstraints { make in
             make.top.equalTo(postsView.snp.top).offset(1)
             make.left.equalToSuperview()
             make.size.equalTo(130)
             
             }
             */
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    /*import SwiftUI
     @available(iOS 13.0,  *)
     struct MainVCProvider: PreviewProvider {
     static var previews: some View {
     ContainerView().edgesIgnoringSafeArea(.all)
     }
     struct ContainerView: UIViewControllerRepresentable {
     func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
     }
     
     let profiVC = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
     func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>)
     -> UIViewController {
     return profiVC
     }
     }*/
    

