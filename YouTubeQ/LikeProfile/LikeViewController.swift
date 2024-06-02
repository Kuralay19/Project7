//
//  LikeViewController.swift
//  YouTubeQ
//
//  Created by Smart Castle M1A2004 on 10.02.2024.
//

import UIKit

class LikeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellid1 = "cellid1"
    let padding: CGFloat = 2
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .red
        setupCollectionView()
    }
    func setupCollectionView() {
        collectionView.isPagingEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(LikeProfileCell.self, forCellWithReuseIdentifier: cellid1)
    }


}
extension LikeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid1, for: indexPath) as! LikeProfileCell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 50)
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return padding
  }
    
}

 



