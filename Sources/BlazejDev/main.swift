import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct BlazejDev: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case about
//        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "http://blazej.dev")!
    var name = "Blazej Wdowikowski"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try BlazejDev().publish(withTheme: .default(), deployedUsing: .gitHub("icanswiftabit/blazej.dev"))

