//
//  LikeProfileCell.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 10.02.2024.
//

import UIKit
import SnapKit
class LikeProfileCell: UICollectionViewCell {
    
    lazy var notificationView = {
        let view = UIView()
       view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    lazy var users_photo : UIImageView = {
        let users_photo = UIImageView()
        users_photo.layer.cornerRadius = 30
        users_photo.contentMode = .scaleAspectFit
        users_photo.image = UIImage(named: "users_photo")?.withRenderingMode(.alwaysOriginal)
        users_photo.translatesAutoresizingMaskIntoConstraints = false
        return users_photo
    }()
    
    lazy var user_name: UILabel = {
        let label = UILabel()
        label.text = "ospanov_go"
        label.textColor = .black
       // label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var liked: UILabel = {
        let label = UILabel()
        label.text = "liked your post"
        label.textColor = .black
      //  label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var post : UIImageView = {
        let post = UIImageView()
        post.image = UIImage(named: "post")?.withRenderingMode(.alwaysOriginal)
        post.translatesAutoresizingMaskIntoConstraints = false
        return post
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    func setupLayouts() {
        addSubview(notificationView)
        notificationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview()
            make.size.equalTo(45)
        }
//        notificationView.addSubview(notification)
//        notification.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(2)
//            make.left.equalToSuperview().offset(12)
//        }
        notificationView.addSubview(users_photo)
                users_photo.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(15)
                    make.left.equalToSuperview().offset(12)
                    make.size.equalTo(45)
                }
                notificationView.addSubview(user_name)
                user_name.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(15)
                    make.left.equalTo(users_photo.snp.right).offset(5)
                    make.width.equalTo(75)
                    make.height.equalTo(25)
        
                }
                notificationView.addSubview(liked)
                liked.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(15)
                    make.left.equalTo(user_name.snp.right).offset(5)
                    make.width.equalTo(100)
                    make.height.equalTo(25)
                }
        notificationView.addSubview(post)
        post.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
