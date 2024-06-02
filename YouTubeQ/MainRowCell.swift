//
//  MainRowCell.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 13.01.2024.
//

import UIKit
import SnapKit
protocol MainRowCellDelegate {
    func didTapLike(post: Post)
    func didTapComment(post: Post)
}
class MainRowCell : UICollectionViewCell {
    var delegate: MainRowCellDelegate?
    
    var didRepostPressed: (()-> Void)?
    
    var post: Post?
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
      //  imageView.backgroundColor = .yellow
        imageView.image = UIImage(named: "fl2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Masha i Medved movie for children"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var videoBacgroundView: UIImageView = {
        let view = UIImageView()
      //  view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var likeButton: UIButton = {
        let like = UIButton()
      //  like.backgroundColor = .red
        like.setImage(UIImage(resource: .likeUnselected), for: .normal)
       // like.setImage(UIImage(named: "like"), for: .normal)
        like.translatesAutoresizingMaskIntoConstraints = false
        return like
    }()
    lazy var commentButton: UIButton = {
        let comment = UIButton()
       // comment.backgroundColor = .blue
        comment.setImage(UIImage(resource: .comment), for: .normal)
        //comment.setImage(UIImage(named: "comment"), for: .normal)
       
        comment.translatesAutoresizingMaskIntoConstraints = false
        return comment
    }()
    lazy var shareButton: UIButton = {
        let share = UIButton()
       // share.backgroundColor = .green
        share.setImage(UIImage(resource: .send2), for: .normal)
        share.translatesAutoresizingMaskIntoConstraints = false
        return share
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie interesting, suggesting to watch when you have family-time "
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
        setupButtonActions()
    }
    
    func setupButtonActions() {
        likeButton.addTarget(self, action: #selector(handleLikePressed), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(handleCommentPressed), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleRepostPressed), for: .touchUpInside)
    }
    
    @objc func handleLikePressed() {
        guard let post = post else { return }
        delegate?.didTapLike(post: post)
    }
    
    @objc func handleCommentPressed() {
        guard let post = post else { return }
        delegate?.didTapComment(post: post)
    }
    
    @objc func handleRepostPressed() {
        guard let post = post else { return }
        didRepostPressed?()
    }
    
    
    func setupLayouts() {
        
        
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(5)
            make.size.equalTo(30)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.top.right.equalToSuperview().offset(9)
           
        }
        
        addSubview(videoBacgroundView)
        videoBacgroundView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(380)
        }
        
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(videoBacgroundView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.size.equalTo(30)
        }
        addSubview(commentButton)
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(videoBacgroundView.snp.bottom).offset(5)
            make.left.equalTo(likeButton.snp.right).offset(10)
            make.size.equalTo(30)
        }
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(videoBacgroundView.snp.bottom).offset(5)
            make.left.equalTo(commentButton.snp.right).offset(10)
            make.size.equalTo(30)
            
            
        }
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(5)
            
            
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
        
     /*   logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
     
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor , constant: 5).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        
        addSubview(separatorLine)
        separatorLine.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10).isActive = true
        separatorLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        separatorLine.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(videoBacgroundView)
        videoBacgroundView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 5).isActive = true
        videoBacgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        videoBacgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        addSubview(likeButton)
        likeButton.topAnchor.constraint(equalTo: videoBacgroundView.bottomAnchor, constant: 2).isActive = true
        likeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(commentButton)
        commentButton.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 2).isActive = true
        commentButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(shareButton)
        shareButton.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 2).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        
        */
        
    
