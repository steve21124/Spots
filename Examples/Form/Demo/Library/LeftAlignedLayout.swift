import UIKit

class LeftAlignedLayout: UICollectionViewFlowLayout {

  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let originalAttributes = super.layoutAttributesForElementsInRect(rect)
    var updatedAttributes = originalAttributes

    if let unwrappedAttributes = updatedAttributes,
      originalAttributes = originalAttributes {
      for attributes in originalAttributes {
        if attributes.representedElementKind == nil {
          guard let index = unwrappedAttributes.indexOf(attributes) else { continue }
          updatedAttributes![index] = self.layoutAttributesForItemAtIndexPath(attributes.indexPath)!
        }
      }
    }
    
    return updatedAttributes
  }

  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    let currentItemAttributes = super.layoutAttributesForItemAtIndexPath(indexPath)
    let sectionInset = evaluatedSectionInsetForItemAtIndex(indexPath.section)
    let isFirstItem = indexPath.item == 0
    let layoutWidth = CGRectGetWidth(collectionView!.frame) - sectionInset.left - sectionInset.right

    if isFirstItem {
      currentItemAttributes?.leftAlignFrameWithSectionInset(sectionInset)
      return currentItemAttributes
    }

    let previousIndexPath = NSIndexPath(forItem: indexPath.item-1, inSection: indexPath.section)
    if let currentItemAttributes = currentItemAttributes,
      previousFrame = self.layoutAttributesForItemAtIndexPath(previousIndexPath)?.frame {
        let previousFrameRightPoint: CGFloat = previousFrame.origin.x - previousFrame.size.width
        let currentFrame = currentItemAttributes.frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left,
          y: currentFrame.origin.y,
          width: layoutWidth,
          height: currentFrame.size.height)

        let isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)

        if (isFirstItemInRow) {
          currentItemAttributes.leftAlignFrameWithSectionInset(sectionInset)
          return currentItemAttributes;
        }

        var frame = currentItemAttributes.frame;
        frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacingForSectionAtIndex(indexPath.section)
        currentItemAttributes.frame = frame
    }

    return currentItemAttributes
  }

  func evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex: Int) -> CGFloat {
    guard let collectionView = collectionView,
      delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout else { return minimumInteritemSpacing }

    if let minimumInteritemSpacing = delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAtIndex: sectionIndex) {
      return minimumInteritemSpacing
    }

    return minimumInteritemSpacing
  }

  func evaluatedSectionInsetForItemAtIndex(sectionIndex: Int) -> UIEdgeInsets {
    guard let collectionView = collectionView,
      delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout
      else { return sectionInset }

    if let sectionInset = delegate.collectionView?(collectionView, layout: self, insetForSectionAtIndex: sectionIndex) {
      return sectionInset
    }

    return sectionInset
  }
}

extension UICollectionViewLayoutAttributes {
  func leftAlignFrameWithSectionInset(sectionInset: UIEdgeInsets) {
    var frame = self.frame
    frame.origin.x = sectionInset.left
    self.frame = frame
  }
}
