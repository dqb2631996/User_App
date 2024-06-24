import UIKit

class AboutTableViewCell: UITableViewCell {
    @IBOutlet weak var bioLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureDetailView(with user: User) {
        bioLabel.text = "user.bio"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
