import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var repoCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureDetailView(with user: User) {
        repoCountLabel.text = user.publicRepos?.description
        followerCountLabel.text = user.followers?.description
        followingCountLabel.text = user.following?.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
