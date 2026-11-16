// cover-letter.typ — styled cover letter matching CV design
// Compile from job-search root:
//   typst compile templates/cover-letter.typ "applications/foo/Cover Letter.pdf" --root . --input cv=/applications/foo/cv-content.yaml --input cl=/applications/foo/cover-letter.yaml

#let cv-path = sys.inputs.at("cv", default: "/master/cv-content.yaml")
#let cl-path = sys.inputs.at("cl", default: "/master/cover-letter.example.yaml")
#let cv = yaml(cv-path)
#let cl = yaml(cl-path)

#set page(paper: "a4", margin: (x: 1.3cm, y: 1.6cm))
#set text(font: ("Helvetica Neue", "Helvetica", "Arial"), size: 9.5pt, lang: "en")
#set par(leading: 0.55em, justify: true)
#set block(spacing: 0.4em)

#let gray = rgb("#666666")
#let div-clr = rgb("#cccccc")

// ── HEADER ───────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 19pt, weight: "bold")[#cv.contact.name]
  #v(-0.5em)
  #text(size: 8.5pt, fill: gray)[
    #cv.contact.location
    #h(0.4em)│#h(0.4em)
    #cv.contact.phone
    #h(0.4em)│#h(0.4em)
    #link("mailto:" + cv.contact.email)[#cv.contact.email]
    #h(0.4em)│#h(0.4em)
    #link(cv.contact.linkedin)[#cv.contact.linkedin.replace(regex("^https?://(www\.)?"), "").trim("/", at: end)]
    #if cv.contact.at("website", default: none) != none [
      #h(0.4em)│#h(0.4em)
      #link("https://" + cv.contact.website)[#cv.contact.website]
    ]
  ]
]

#v(0.2em)
#line(length: 100%, stroke: 0.5pt)
#v(0.6em)

// ── META ─────────────────────────────────────────────────────────────────────
#text(fill: gray)[#cl.meta.date]
#v(0.4em)
#text(weight: "bold")[#cl.meta.role]
#linebreak()
#cl.meta.company
#v(0.6em)

#line(length: 100%, stroke: 0.5pt)
#v(0.6em)

// ── BODY ─────────────────────────────────────────────────────────────────────
#let hm = cl.body.at("hiring_manager", default: "")
#if hm != "" [
  Dear #hm,
] else [
  Dear Hiring Manager,
]

#v(0.4em)

#cl.body.opening

#v(0.4em)

#for para in cl.body.paragraphs {
  para
  v(0.4em)
}

#cl.body.closing

#v(0.6em)
Thank you for your consideration,

#v(0.6em)
#cv.contact.name
