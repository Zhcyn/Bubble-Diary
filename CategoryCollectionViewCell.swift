import UIKit
class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var isCreated: Bool = false
    var numberOfArr: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell() {
        if self.isSelected {
            self.contentView.layer.opacity = 1
        } else {
            self.contentView.layer.opacity = 0.3
        }
    }
    override var isSelected: Bool {
        didSet {
            self.contentView.layer.opacity = isSelected ? 1 : 0.3
            self.imageView.alpha = isSelected ? 1 : 1.0
        }
    }
}
