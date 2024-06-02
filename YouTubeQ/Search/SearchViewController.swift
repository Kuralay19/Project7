//
//  SearchViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 27.01.2024.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var filteredUsers = [User]()
    var users = [User]()
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = false
        searchController.searchBar.placeholder = "Search "
        searchController.obscuresBackgroundDuringPresentation = false
        collectionView.backgroundColor = .white
        collectionView.register(SearchRowCell.self, forCellWithReuseIdentifier: "cellid")
        fetchUser()
    }
    struct User {
        let uid: String
        let username: String
        let profileImageUrl: String
        
        init(uid: String, dictionary: [String:Any]) {
            self.uid = uid
            self.username = dictionary["username"] as? String ?? ""
            self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        }
    }
   
    fileprivate func fetchUser() {
        print ("fetching users")
        
        let ref = Database.database().reference().child("users")
        ref.observe(.value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else { return }
            dictionaries.forEach({ (key, value) in
                if key == Auth.auth().currentUser?.uid {
                    print("found myself, omit from list")
                    return
                }
                guard let userDictionary = value as? [String: Any]
                else {return}
                
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
            })
            self.users.sort(by: { (u1, u2) -> Bool in
                return u1.username.compare(u2.username) == .orderedAscending
            })
            self.filteredUsers = self.users
            self.collectionView.reloadData()
        }) { (err) in
            print ("Failed to fetch users for search:",err)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = self.users.filter { (user) -> Bool in
                return user.username.lowercased().contains(searchText.lowercased())
            }
        }
        self.collectionView.reloadData()
        
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! SearchRowCell
        cell.account_name.text = filteredUsers[indexPath.item].username
        cell.profilePicture.download(from: filteredUsers[indexPath.item].profileImageUrl)
        cell.detailLabel.text = filteredUsers[indexPath.item].uid
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return.init(width: collectionView.frame.width, height: 60)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = self.filteredUsers[indexPath.item]
        let vc = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        vc.user = user
        vc.fromOtherPages = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
