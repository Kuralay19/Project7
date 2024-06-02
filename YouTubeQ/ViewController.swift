//
//  ViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 06.01.2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Kingfisher

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MainRowCellDelegate {
    let cellid1 = "cellid1"
    var posts = [Post]()
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(resource: .camera3), style: .plain, target: self, action: #selector(handleOpenCamera))
    }
    @objc func handleOpenCamera() {
        let vc = CameraController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser == nil {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .overFullScreen
            let navController = UINavigationController(rootViewController: loginViewController)
            self.navigationController?.present(navController, animated: true )
        }
        
        fetchUser()
    }
    let downloadGroup = DispatchGroup()
    private func fetchUser() {
        //guard let uid = (Auth.auth().currentUser?.uid) else { return }
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: {snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            self.posts.removeAll()
            dictionary.forEach { key, value in
                let user = User(uid: key, dictionary: value as!  [String : Any])
                if user.uid == Auth.auth().currentUser?.uid {
                    self.currentUser = user
                }
                print("1")
                self.fetchOrderedPosts(user: user) {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
            }
            //            DispatchQueue.main.async {
            //                self.collectionView.reloadData()
            //            }
        })
        //        downloadGroup.notify(queue: .main) {
        //            print("all posts donloaded for per user")
        //            DispatchQueue.main.async {
        //                self.collectionView.reloadData()
        //            }
        //
        //        }
    }
    private func fetchOrderedPosts(user: User, completion: @escaping() -> Void) {
        let uid = user.uid
        let ref = Database.database().reference().child("posts").child(uid)
        
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else {
                completion()
                return
            }
            
            var post = Post(user: user, dictionary: dictionary)
            
            if post.id == nil {
                post.id = UUID().uuidString
            }
            if post.likedUsers.contains(self.currentUser?.uid ?? "") {
                post.hasLiked = true
            } else {
                post.hasLiked = false
            }
            
            //сортировка когда заливают новый пост он первый
            self.posts.append(post)
            
            self.posts = self.posts.sorted(by: { $0.creationDate > $1.creationDate }).uniqued()
            //            self.downloadGroup.leave()
            //            DispatchQueue.main.async {
            //                self.collectionView.reloadData()
            //            }
            completion()
        }) { (err) in
            print("Failed to fetch ordered posts:",err)
            completion()
        }
        
    }
    func setupCollectionView() {
        // collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(MainRowCell.self, forCellWithReuseIdentifier: cellid1)
    }
}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid1, for: indexPath) as! MainRowCell
        let post = posts[indexPath.item]
        cell.post = post
        cell.delegate = self
        cell.didRepostPressed = {
            print("repost Pressed \(post.creationDate.timeIntervalSince1970)")
        }
        
        cell.nameLabel.text = post.user?.username
        cell.logoImageView.kf.setImage(with: URL(string: post.user?.profileImageUrl ?? ""))
        cell.videoBacgroundView.kf.setImage(with: URL(string: post.imageUrl))
        cell.descriptionLabel.text = post.caption
        cell.likeButton.setImage(UIImage(resource: post.hasLiked ? .likeSelected : .likeUnselected), for: .normal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 500)
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return 0
    //    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = posts[indexPath.item].user
        let vc = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.user = user
        vc.fromOtherPages = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func didTapLike(post: Post) {
        print("didTapLike \(post.creationDate.timeIntervalSince1970)")
        guard let currentUser = currentUser,
              let postId = post.id,
              let postOwnerId = post.user?.uid
        else { return }
        let dataRef = Database.database().reference().child("posts").child(postOwnerId).child(postId).child("likedUsers")
        dataRef.observeSingleEvent(of: .value) { snapshot in
            var likedUsers = snapshot.value as? [String: String] ?? [:]
            var hasLiked = post.hasLiked
            if let value = likedUsers[currentUser.uid] {
                likedUsers.removeValue(forKey: currentUser.uid)
                hasLiked = false
            } else {
                likedUsers[currentUser.uid] = currentUser.username
                hasLiked = true
            }
            dataRef.setValue(likedUsers)
            if let postIndex = self.posts.firstIndex(where: { $0.id == postId }) {
                self.posts[postIndex].hasLiked = hasLiked
                DispatchQueue.main.async {
                    self.collectionView.reloadItems(at: [IndexPath(item: postIndex, section: 0)])
                }
            }
        }
    }
    func fetchLikedPost() {
        Database.database().reference().child("likes").observeSingleEvent(of: .value, with:  { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            dictionary.forEach{ key, value in
                guard let valueDictionanory = value as? [String:Any] else {return }
                self.posts.forEach {post in
                    if post.id == key {
                        if let index = self.posts.firstIndex(where:{ $0.id == post.id } ) {
                            self.posts[index].hasLiked = ((valueDictionanory["like"] as? Bool) ?? false)
                        }
                    }
                }
            }
        })
    }
    
    func didTapComment(post: Post) {
        print("didTapComment \(post.creationDate.timeIntervalSince1970)")
    }
}


public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}






