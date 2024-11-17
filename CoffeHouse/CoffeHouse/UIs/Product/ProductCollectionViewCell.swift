import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sizeS: UILabel!
    @IBOutlet weak var sizeM: UILabel!
    @IBOutlet weak var sizeL: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!

    var sizes = [SizeModelMain]() {
        didSet {
            updateSizeLabels()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpImageSize()
        setUpLabel(sizeS)
        setUpLabel(sizeM)
        setUpLabel(sizeL)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 25
    }

    func setUpImageSize() {
        imageProduct.translatesAutoresizingMaskIntoConstraints = false
        imageProduct.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageProduct.widthAnchor.constraint(equalToConstant: 130).isActive = true
        imageProduct.layer.cornerRadius = 25
        imageProduct.clipsToBounds = true
        imageProduct.contentMode = .scaleAspectFill
    }
    func setUpLabel(_ label: UILabel) {
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.colorCustomBrown.cgColor
        label.clipsToBounds = true
        
    }

    func setUpCellProduct(products: ProductModel) {
        name.text = products.nameProduct
        price.text = String(products.price) + "$"
        if let imageURL = URL(string: products.urlImage) {
            imageProduct.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        } else {
            imageProduct.image = UIImage(named: "placeholder")
        }
    }

    private func updateSizeLabels() {
        // Hide all labels initially
        sizeS.isHidden = true
        sizeM.isHidden = true
        sizeL.isHidden = true

        for size in sizes {
            switch size.idSize {
                case 0:
                    sizeS.text = size.name
                    sizeS.isHidden = size.name.isEmpty
                case 1:
                    sizeM.text = size.name
                    sizeM.isHidden = size.name.isEmpty
                case 2:
                    sizeL.text = size.name
                    sizeL.isHidden = size.name.isEmpty
                default:
                    break
            }
        }
    }
}
