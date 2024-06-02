//
//  MiniPostsCell.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 10.02.2024.
//
import UIKit
import SnapKit
class MiniPostsCell: UICollectionViewCell {
    /*lazy var postsView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }() */
    lazy var firstPost : UIImageView = {
        let firstPost = UIImageView()
        //firstPost.contentMode = .scaleAspectFill
       // firstPost.image = UIImage(named: "image")?.withRenderingMode(.alwaysOriginal)
        firstPost.translatesAutoresizingMaskIntoConstraints = false
        return firstPost
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    func setupLayouts() {
    addSubview(firstPost)
        firstPost.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
