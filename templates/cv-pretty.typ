// cv-pretty.typ — single-column, ATS-safe, styled CV
// Compile from job-search root:
//   typst compile templates/cv-pretty.typ "master/CV.pdf" --root .
// Per application:
//   typst compile templates/cv-pretty.typ "applications/foo/CV.pdf" --root . --input content=/applications/foo/cv-content.yaml

#let content-path = sys.inputs.at("content", default: "/master/cv-content.yaml")
#let data = yaml(content-path)

#set page(paper: "a4", margin: (x: 1.3cm, y: 1.6cm))
#set text(font: ("Helvetica Neue", "Helvetica", "Arial"), size: 9.5pt, lang: "en")
#set par(leading: 0.55em, justify: false)
#set block(spacing: 0.4em)

#let gray    = rgb("#666666")
#let div-clr = rgb("#cccccc")

#let fmt(s) = {
  let parts = s.split("**")
  for (i, part) in parts.enumerate() {
    if calc.odd(i) { strong(part) } else { part }
  }
}

#let section-head(t) = {
  v(0.2em)
  text(size: 9.5pt, weight: "bold", upper(t))
  v(0.1em)
  line(length: 100%, stroke: 0.5pt)
  v(0.2em)
}

// ── HEADER ───────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 19pt, weight: "bold")[#data.contact.name]
  #v(-0.5em)
  #text(size: 8.5pt, fill: gray)[
    #data.contact.location
    #h(0.4em)│#h(0.4em)
    #data.contact.phone
    #h(0.4em)│#h(0.4em)
    #link("mailto:" + data.contact.email)[#data.contact.email]
    #h(0.4em)│#h(0.4em)
    #link(data.contact.linkedin)[#data.contact.linkedin.replace(regex("^https?://(www\.)?"), "").trim("/", at: end)]
    #if data.contact.at("website", default: none) != none [
      #h(0.4em)│#h(0.4em)
      #link("https://" + data.contact.website)[#data.contact.website]
    ]
  ]
]
#v(-0.3em)

// ── PROFILE ──────────────────────────────────────────────────────────────────
#section-head("Profile")
#data.profile

// ── HIGHLIGHTS ───────────────────────────────────────────────────────────────
#section-head("Highlights")
#for h in data.highlights {
  [• #h.replace("**", "")\ ]
}

// ── WORK HISTORY ─────────────────────────────────────────────────────────────
#section-head("Work History")
#{
  for job in data.experience {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      [#text(weight: "bold")[#job.title#if job.company.len() > 0 [, #job.company]]],
      [#text(size: 8.5pt, fill: gray)[#job.period | #job.location]],
    )
    v(0.1em)
    if job.sub_roles.len() > 0 {
      for sub in job.sub_roles {
        v(0.02em)
        text(style: "italic")[#sub.sub_title]
        v(-0.5em)
        for b in sub.bullets {
          [• #b\ ]
        }
      }
    } else {
      for b in job.bullets {
        [• #b\ ]
      }
    }
    v(0.75em)
  }
}

// ── EDUCATION ────────────────────────────────────────────────────────────────
#section-head("Education")
#{
  for edu in data.education {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      [#text(weight: "bold")[#edu.degree], #edu.institution],
      [#text(size: 8.5pt, fill: gray)[#edu.period | #edu.location]],
    )
    v(0.05em)
    text(style: "italic")[#edu.note]
    v(0.2em)
  }
}

// ── SKILLS ───────────────────────────────────────────────────────────────────
#section-head("Skills")
#data.skills.tools \
#data.skills.languages

// ── ADDITIONAL ───────────────────────────────────────────────────────────────
#if data.additional.len() > 0 {
  section-head("Additional")
  for item in data.additional {
    [• #item\ ]
  }
}
