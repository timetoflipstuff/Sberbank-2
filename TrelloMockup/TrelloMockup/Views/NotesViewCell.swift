import UIKit

class NotesViewCell: UITableViewCell {
    
    public static let reuseId = "noteCell"
    
    private let nameLable = UILabel()
    private var imgView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLable.font = .systemFont(ofSize: 20)
        
        imgView.backgroundColor = .orange
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imgView)
        contentView.addSubview(nameLable)
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: 1).isActive = true
        
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        nameLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        nameLable.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8).isActive = true
        nameLable.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: 8).isActive = true
    }
    
    public func setupUI(_ uiNote: UINote){
        nameLable.text = uiNote.name
        imgView.image = uiNote.img
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
