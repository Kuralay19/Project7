import UIKit
class SearchRowCell: UICollectionViewCell {
  
    lazy var profilePicture: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var account_name: UILabel = {
        let label = UILabel()
        label.text = "quralai"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    } ()
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Quralay Qairatzhanqyzy"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
   
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI() {
        addSubview(profilePicture)
        profilePicture.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.size.equalTo(30)
        }
       
        addSubview(account_name)
        account_name.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(5)
            make.left.equalTo(profilePicture.snp.right).offset(3)
        }
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(account_name.snp.bottom).offset(1)
            make.left.equalTo(profilePicture.snp.right).offset(3)
            make.right.equalToSuperview().inset(5)
        }
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
