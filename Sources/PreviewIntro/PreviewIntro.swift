import UIKit

public struct PreviewIntro {
    let headline: String
    let description: String
    let image: UIImage?
    let backgroundColor: UIColor
    let headlineColor: UIColor
    let headlineFont: UIFont
    let descriptionColor: UIColor
    let descriptionFont: UIFont

    init(
        headline: String,
        description: String,
        image: UIImage? = nil,
        backgroundColor: UIColor = .systemBackground,
        headlineColor: UIColor = .label,
        headlineFont: UIFont = .systemFont(ofSize: 30, weight: .bold),
        descriptionColor: UIColor = .label,
        descriptionFont: UIFont = .systemFont(ofSize: 20, weight: .regular)
    ) {
        self.headline = headline
        self.description = description
        self.image = image
        self.backgroundColor = backgroundColor
        self.headlineColor = headlineColor
        self.headlineFont = headlineFont
        self.descriptionColor = descriptionColor
        self.descriptionFont = descriptionFont
    }
}
