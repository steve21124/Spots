import UIKit
import GoldenRetriever
import Sugar
import Spots

class GridSpotHeader : UICollectionViewCell, Itemble {

  var size = CGSize(width: 0, height: 320)
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
    imageView.autoresizingMask = [.FlexibleWidth]
    return imageView
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    contentView.addSubview(imageView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(inout item: ListItem) {
    optimize()
    
    if !item.image.isEmpty {
      imageView.image = nil
      let resource = item.image
      let fido = GoldenRetriever()

      dispatch(queue: .Interactive) {
        fido.fetch(resource) { data, error in
          guard let data = data else { return }
          let image = UIImage(data: data)
          dispatch { [weak self] in
            self?.imageView.image = image
          }
        }
      }
    }
    
    imageView.frame = contentView.frame
    item.size.height = 320
  }
}