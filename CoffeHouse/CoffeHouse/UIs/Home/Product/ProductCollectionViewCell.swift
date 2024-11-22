import UIKit
import SDWebImage
protocol ProductCollectionViewCellDelegate: AnyObject { func didTapFavoriteButton(for product: ProductModel) }
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sizeS: UILabel!
    @IBOutlet weak var sizeM: UILabel!
    @IBOutlet weak var sizeL: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!

    @IBOutlet weak var btnAddToFavourite: UIButton!
    @IBOutlet weak var addFavourite: UIButton!
    
    weak var delegate: ProductCollectionViewCellDelegate?
    var favButtonPressed: (() -> ()) = {}
    
    var goDetail: (() -> ())?
    
    var sizes = [SizeModelMain]() {
        didSet {
            updateSizeLabels()
        }
    }
    var product: ProductModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpImageSize()
        name.font = FontFamily.Montserrat.semiBold.font(size: 14)
        price.font = FontFamily.Montserrat.regular.font(size: 12)
        setUpLabel(sizeS)
        setUpLabel(sizeM)
        setUpLabel(sizeL)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 25
    }
    @IBAction func goDetail(_ sender: Any) {
        goDetail?()
    }
    
    @IBAction func btnAddToFavourite(_ sender: UIButton) {
        favButtonPressed()
    }
    
    @IBAction func didTapFavourite(_ sender: Any) {
        guard let product = product else { return }
        delegate?.didTapFavoriteButton(for: product)
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
        label.font = FontFamily.Montserrat.regular.font(size: 12)
        
    }

    func setUpCellProduct(products: ProductModel) {
        self.product = products
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
