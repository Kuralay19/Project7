//
//  ProfilePostsCell.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 10.02.2024.
//

//import UIKit
//import SnapKit
//class ProfilePostsCell: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    let cellid = "cellid"
//    let cellid1 = "cellid1"
//    let padding: CGFloat = 1
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCollectionView()
//    }
//    func setupCollectionView() {
//        collectionView.backgroundColor = .white
//        collectionView.register(ProfileRowCell.self, forCellWithReuseIdentifier: cellid)
//        collectionView.register(ProfileRowCell.self, forCellWithReuseIdentifier: cellid1)
//      /*  collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellid)
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = .init(width: view.frame.width, height: UICollectionViewFlowLayout.automaticSize.height)
//        } */
//    }
//   
//       /* if indexPath.item == 0 {
//            let dummyCell = ProfileRowCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//            dummyCell.layoutIfNeeded()
//            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
//            return CGSize(width: collectionView.frame.width, height: estimatedSize.height)
//        }
//        let itemWidth = collectionView.frame.width/3
//        return CGSize(width: itemWidth, height: itemWidth)
//    }
//   */
//}
//extension ProfilePostsCell {
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! ProfilePostsCell
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.item == 0 {
//             let dummyCell = ProfileRowCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
//             dummyCell.layoutIfNeeded()
//             let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
//             return CGSize(width: collectionView.frame.width, height: estimatedSize.height)
//         }
//         let itemWidth = collectionView.frame.width/3
//         return CGSize(width: itemWidth, height: itemWidth)
//     }
//     
//    
//    
//}
//
