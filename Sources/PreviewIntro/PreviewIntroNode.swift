import AsyncDisplayKit

public final class PreviewIntroNode: ASDisplayNode {
    private let headlineTextNode = ASTextNode()
    private let backgroundImageNode = ASImageNode()
    private let descriptionTextNode = ASTextNode()

    public func configure(with preview: PreviewIntro) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .justified

        headlineTextNode.attributedText = NSAttributedString(
            string: preview.headline,
            attributes: [
                .font: preview.headlineFont,
                .foregroundColor: preview.headlineColor
            ]
        )

        descriptionTextNode.attributedText = NSAttributedString(
            string: preview.description,
            attributes: [
                .font: preview.descriptionFont,
                .foregroundColor: preview.descriptionColor,
                .paragraphStyle: paragraph
            ]
        )

        backgroundColor = preview.backgroundColor
        backgroundImageNode.image = preview.image
        animateAppearance()
    }

    private func animateAppearance() {
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseInOut) {
            self.headlineTextNode.alpha = 1
        }

        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseInOut) {
            self.backgroundImageNode.alpha = 1
        }

        UIView.animate(withDuration: 0.6, delay: 0.5, options: .curveEaseInOut) {
            self.descriptionTextNode.alpha = 1
        }
    }

    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let top = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 16, bottom: 5, right: 16),
            child: headlineTextNode
        )

        let center = ASCenterLayoutSpec(
            centeringOptions: .XY,
            sizingOptions: [],
            child: backgroundImageNode
        )

        let bottom = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16),
            child: descriptionTextNode
        )

        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20,
            justifyContent: .center,
            alignItems: .center,
            children: [top, center, bottom]
        )
    }

    private func setupAccessibility() {
        headlineTextNode.isAccessibilityElement = true
        headlineTextNode.accessibilityTraits = .header

        descriptionTextNode.isAccessibilityElement = true
        descriptionTextNode.accessibilityTraits = .staticText

        backgroundImageNode.isAccessibilityElement = true
        backgroundImageNode.accessibilityTraits = .image
    }

    private func setupUI() {
        automaticallyManagesSubnodes = true
        headlineTextNode.alpha = 0
        descriptionTextNode.alpha = 0
        backgroundImageNode.contentMode = .scaleAspectFit
        backgroundImageNode.alpha = 0
    }

    public override init() {
        super.init()
        setupUI()
        setupAccessibility()
    }
}
