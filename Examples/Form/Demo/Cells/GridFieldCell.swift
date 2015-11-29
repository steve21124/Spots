import UIKit
import GoldenRetriever
import Sugar
import Tailor
import Spots

class GridFieldCell: UICollectionViewCell, Itemble {

  var size = CGSize(width: 125, height: 160)
  
  lazy var label: UILabel = { [unowned self] in
    let label = UILabel(frame: CGRectZero)
    label.font = UIFont.boldSystemFontOfSize(11)
    label.numberOfLines = 4
    label.textAlignment = .Center
    label.autoresizingMask = [.FlexibleWidth]

    return label
    }()

  lazy var blurView: UIVisualEffectView = {
    let view = UIVisualEffectView()
    view.effect = UIBlurEffect(style: .Light)

    return view
  }()

  lazy var paddedStyle: NSParagraphStyle = {
    let style = NSMutableParagraphStyle()
    style.alignment = .Center

    return style
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 3

    [label].forEach { contentView.addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  func configure(inout item: ListItem) {
    backgroundColor = UIColor.lightGrayColor()
    label.attributedText = NSAttributedString(string: item.title,
      attributes: [NSParagraphStyleAttributeName : paddedStyle])
    label.frame.size.height = 38

    item.size.height = 66
  }
}
