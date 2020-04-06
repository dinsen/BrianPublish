import BrianPublishTheme
import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct Brian: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://brian.dk")!
    var name = "Brian"
    var description = "A description of Brian"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using my brian theme:
try Brian().publish(using: [
    .installPlugin(.splash(withClassPrefix: "")),
    .addMarkdownFiles(),
    .copyResources(),
    .sortItems(by: \.date, order: .descending),
    .generateHTML(withTheme: .brian, indentation: .tabs(1)),
    .generateRSSFeed(including: [.posts]),
    .generateSiteMap()
])
