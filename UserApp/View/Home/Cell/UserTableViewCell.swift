import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let imageCache = NSCache<NSString, UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureDetailView(with user: User) {
        // Thiết lập dữ liệu cho cell
        titleLabel.text = user.id.description
        subtitleLabel.text = user.login
        // Load ảnh avatar từ URL
        if let cachedImage = imageCache.object(forKey: user.avatarUrl as NSString) {
            avatarImageView.image = cachedImage
        } else {
            avatarImageView.image = nil
            downloadImage(from: user.avatarUrl)
        }
    }
    
    private func downloadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                self.avatarImageView.image = image
            }
        }.resume()
    }
   
}
