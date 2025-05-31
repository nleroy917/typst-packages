#import "utils.typ"

#let uservars = (
    headingfont: "Arial", // Set font for headings
    bodyfont: "Arial",   // Set font for body
    fontsize: 10pt,
    linespacing: 5pt,
)

// set rules
#let setrules(uservars, doc) = {

    // heading settings
    show heading.where( level: 1 ): set text(
        font: uservars.headingfont,
        size: 16pt,
    )
    show heading.where( level: 2 ): set text(
        font: uservars.headingfont,
        size: 14pt,
    )

    // set page layout
    set page(
        paper: "us-letter", // a4, us-letter
        number-align: center, // left, center, right
        margin: 0.5in
    )

    // set text settings
    set text(
        font: uservars.bodyfont,
        size: uservars.fontsize,
        hyphenate: false,
    )

    // set paragraph settings
    set par(
        leading: uservars.linespacing,
        justify: true,
    )

    doc
}

// set page layout
#let init(doc) = {
    doc = setrules(uservars, doc)
    doc
}

#let title(title_content) = {
    block(width: 100%)[
        #set align(left)
        #title_content
    ]
}

#let authors(author_data) = {
    let authorn = 1
    for author in author_data.authors {
        let author_string = box({
            let affiln = 1
            box[#author.name]
            for affiliation in author.affiliations {
                super[#affiliation]
                if affiln < author.affiliations.len() {
                    super[,]
                }
                affiln += 1
            }
            if author.keys().contains("correspondence") {
                box[#super[#link("mailto:" + author.correspondence)[ ✉]]]
            }
            if authorn < author_data.authors.len() {
                ", "
            }
        })
        authorn += 1
        author_string
    }
    linebreak()
}

#let affiliations(author_data) = {
    linebreak()
    for affil in author_data.affiliations.pairs() {
        let affiliation_string = box({
            set text(size: 8pt)
            super([#affil.at(0)])
            [#affil.at(1)]
        })
        affiliation_string
    }
}

#let abstract(content) = {
    // links
    show link: underline
    rect([
        #pad(
            [ #content ],
            x: 0.5pt, 
            y: 0.5pt
        )
    ],
        fill: rgb("#f0f0f0")
    )
    
}

// manuscript content
#let manuscript(doc) = {
    columns(2, [
        #doc
    ])
}