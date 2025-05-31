#import "utils.typ"

#let uservars = (
    headingfont: "Linux Libertine", // Set font for headings
    bodyfont: "Linux Libertine",   // Set font for body
    fontsize: 12pt, // 10pt, 11pt, 12pt
    linespacing: 6pt,
)

#let setrules(uservars, doc) = {
    set page(
        paper: "us-letter", // a4, us-letter
        number-align: center, // left, center, right
        margin: 1.87cm, // 1.25cm, 1.87cm, 2.5cm
    )

    // Set Text settings
    set text(
        font: uservars.bodyfont,
        size: uservars.fontsize,
        hyphenate: false,
    )

    // Set Paragraph settings
    set par(
        leading: uservars.linespacing,
        justify: true,
    )

    doc
}

// show rules
#let showrules(uservars, doc) = {
    // Uppercase Section Headings
    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #set align(left)
        #set text(font: uservars.headingfont, size: 1em, weight: "bold")
        #upper(it.body)
        #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // Draw a line
    ]

    // Name Title
    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
        #upper(it.body)
        #v(2pt)
    ]

    doc
}

// Set Page Layout
#let letterinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)

    doc
}

#let addresstext(info) = {
    box(link("mailto:" + info.personal.email))
    linebreak()
    box(link("tel:" + info.personal.phone))
    linebreak()
    box(info.professional.company)
    linebreak()
    box(block()[
        #info.personal.location.city, #info.personal.location.region, #info.personal.location.postalCode
        
    ])
    
}

// Create layout of the title + contact info
#let letterheading(info, uservars) = {
  grid(
      columns: (1fr, 1fr),
      align(left)[
          = #info.personal.name
          #text(size: 14pt, weight: "light")[
            #info.professional.title
            #v(-4pt)
          ]
      ],
      align(right)[
        #addresstext(info)
      ]
  )
}

#let currentdate() = {
    let date = datetime.today()
    let month = utils.monthname(date.month() - 1)
    let day = date.day()
    let year = date.year()
    align(right)[
        #month #day, #year
    ]
}

#let salutation() = {
    align(left)[
        Recruiting team,
        #v(1em)
    ]
}

#let body(content) = {
    align(left)[
        #content
    ]
}