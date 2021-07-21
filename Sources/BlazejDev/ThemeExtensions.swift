import Foundation
import Publish
import Plot

extension Theme {
    static func `default`() -> Self { Theme(htmlFactory: DefaultHTMLFactory()) } 
}

struct DefaultHTMLFactory<Site: Website>: HTMLFactory {
    private let stylesheet: Path = "app.css"

    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site, stylesheetPaths: [stylesheet]),
            .body(
                .nav(.if((context.sections.ids.count > 1), .ul(
                    .forEach(Site.SectionID.allCases) { section in
                        .li(.a(
                            .href(context.sections[section].path),
                            .text(context.sections[section].title)
                        ))
                    }
                ))),
                .main(
                    .div(.class("content"),
                         .contentBody(context.pages.first?.value.body ?? "")
                    )),
                .footer()
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>, context: PublishingContext<Site>) throws -> HTML {
        // Items
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                // Header
                //              .h1(.text(context.site.name)),
                //              .h2(.text(context.site.description)),
                // Navigation
                .nav(.if((context.sections.ids.count > 1), .ul(
                    .forEach(Site.SectionID.allCases) { section in
                        .li(.a(
                            .href(context.sections[section].path),
                            .text(context.sections[section].title)
                        ))
                    }
                ))
                ),
                .ul(.forEach(section.items) { item in
                    .li(
                        .a(
                            .href(item.path),
                            .text(item.title)
                        ),
                        .p(.text(item.description))
                    )
                })
            )
        )
        //
    }

    func makeItemHTML(for item: Item<Site>, context: PublishingContext<Site>) throws -> HTML {
        HTML(.text("item"))
    }

    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(.text("page"))
    }

    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? { nil }

    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? { nil }

    //    private func content(for index: Index, with context: PublishingContext<Site>, in section: Site.SectionID?) -> HTML {
    //        if section == context.sections.ids.first {
    //            return HTML(
    //                    .lang(context.site.language),
    //                    .head(for: index, on: context.site, stylesheetPaths: [stylesheet]),
    //                        .body(
    //                            .header(
    //                                .nav(.ul(
    //                                  .forEach(Site.SectionID.allCases) { section in
    //                                    .li(.a(
    //                                      .class(section == selectedSection ? "selected" : ""),
    //                                      .href("/"),
    //                                      .text(context.sections[section].title.uppercased())
    //                                    ))
    //                                  },
    //                                  .forEach(pagePaths.compactMap { context.pages[$0] }) { page in
    //                                    .li(.a(
    //                                      .class(page == selectedPage ? "selected" : ""),
    //                                      .href(page.path),
    //                                      .text(page.content.title.uppercased())
    //                                    ))
    //                                  },
    //                                  .forEach(navigationLinks) { link in
    //                                    .li(.a(.target(.blank), .href(link.url), .text(link.name.uppercased())))
    //                                  }
    //                                ))
    //                            )
    //                        )
    //                    )
    //        } else {
    //            return HTML(.text("not about"))
    //        }
    //    }
}

private extension Node where Context == HTML.BodyContext {
    static func footer() -> Node {
        .footer(
            .div(.class("divider")),
            .div(
                .id("footer-content"),
                .p(
                    .text("Created by "),
                    .a(
                        .text("Blazej Wdowikowski"),
                        .href("https://twitter.com/icanswiftabit")
                    ),
                    .text(" with "),
                    .a(
                        .text("Publish"),
                        .href("https://github.com/JohnSundell/Publish")
                    )
                )
            )
        )
    }
}
