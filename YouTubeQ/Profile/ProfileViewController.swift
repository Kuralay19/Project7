//
//  ProfileViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 03.02.2024.
//

import UIKit
import SnapKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellid = "cellid"
    let cellid1 = "cellid1"
    let padding: CGFloat = 0.5
    
    var fromOtherPages = false
    var user: User?
    
    var posts = [Post]()
    var isFinishedPaging = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileRowCell.self, forCellWithReuseIdentifier: cellid)
        collectionView.register(MiniPostsCell.self, forCellWithReuseIdentifier: cellid1)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUser()
    }
   
    func paginatePosts() {
        guard let user = self.user else { return }
        let uid = user.uid
        let ref = Database.database().reference().child("posts").child(uid)
        var query = ref.queryOrdered(byChild: "creationDate")
        if posts.count > 0 {
            let value = posts.last?.creationDate.timeIntervalSince1970
            query = query.queryEnding(atValue: value)
        }
        query.queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            guard var allObjects = snapshot.children.allObjects as? [DataSnapshot] else {return}
            allObjects.reverse()
            if allObjects.count < 4 {
                self.isFinishedPaging = true
            }
            if self.posts.count > 0 && allObjects.count > 0 {
                allObjects.removeFirst()
            }
            allObjects.forEach({ snapshot  in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                var post = Post(user: user, dictionary: dictionary)
                post.id = snapshot.key
                self.posts.append(post)
            })
            self.posts.forEach({ (post) in
                print(post.id ?? "" )
            })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) { (err) in
            
            self.fetchOrderedPosts()
            print("Failed to paging for posts: ",err)
            
        }
    }
    
    private func fetchOrderedPosts() {
        posts.removeAll()
        guard let uid = self.user?.uid else {return}
        let ref = Database.database().reference().child("posts").child(uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else { return}
            guard let user = self.user else {return}
            let post = Post(user: user, dictionary: dictionary)
            self.posts.insert(post, at: 0)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) { (err) in
            print("Failed to fetch ordered posts", err)}
    }
    
    
    private func fetchUser() {
        guard let uid = (Auth.auth().currentUser?.uid) else { return }
        Database.database().reference().child("users").child("\(uid)").observeSingleEvent(of: .value, with: {snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            self.user = User(uid: uid, dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            self.paginatePosts()
            
            
            
        })
    }
}


extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ProfileRowCell
            cell.settingsButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
            DispatchQueue.main.async {
                cell.profile_photo.download(from: self.user?.profileImageUrl ?? "")
                cell.account_name.text = self.user?.username
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid1, for: indexPath) as! MiniPostsCell
            cell.firstPost.download(from: posts[indexPath.item - 1].imageUrl)
            return cell
        }
    }
    @objc func handleSignOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("already logged out")
        }
        if Auth.auth().currentUser == nil {
            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .overFullScreen
            
         //   loginViewController.modalTransitionStyle = .
            let navController = UINavigationController(rootViewController: loginViewController)
            self.navigationController?.present(navController, animated: true )
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            //            let dummyCell = ProfileRowCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            //            dummyCell.layoutIfNeeded()
            //            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return CGSize(width: collectionView.frame.width, height: 350)
        }
        
        let itemWidth = collectionView.frame.width/3 - padding
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}


