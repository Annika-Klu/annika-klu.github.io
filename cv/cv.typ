// Renders cv.yml as a PDF. From the project root (or use the npm scripts):
//   typst compile --root . --font-path cv/fonts cv/cv.typ cv/cv-en.pdf
//   typst compile --root . --font-path cv/fonts --input lang=de cv/cv.typ cv/cv-de.pdf
// --root . lets the template read the version from package.json.
// Add `--input private=true` for the private variant: contact details and
// photo from the gitignored private.yml (see private.example.yml).

#let data = yaml("cv.yml")
#let langs = ("en", "de")
#let lang = sys.inputs.at("lang", default: "en")
#assert(lang in langs, message: "unsupported lang: " + lang)
#let private = sys.inputs.at("private", default: "false") == "true"
// Site version, stored in the PDF metadata to tell which CV a recipient has.
#let version = json("/package.json").version
#let build-date = datetime.today()
#let private-data = if private { yaml("private.yml") } else { (:) }
#let contact-data = data.contact + private-data.at("contact", default: (:))
#let photo = private-data.at("photo", default: none)

// ---------------------------------------------------------------------------
// Design tokens

#let ink = rgb("#1d2529")
#let muted = rgb("#66737a")
#let accent = rgb("#2a8c9d") // headings: brighter, still legible on white (3.9:1)
#let accent-deco = rgb("#2ea0b3") // rules, bullets, separators (graphics need 3:1)
#let accent-light = rgb("#57c2d6") // site accent, used on the dark header
#let header-fill = gradient.linear(rgb("#0c2927"), rgb("#0d1a2b"), angle: 20deg)

#let sans = "Inter"
#let mono = "JetBrains Mono"
#let body-size = 9.5pt
#let meta-size = 7.5pt

#let margin = (x: 1.8cm, top: 1.5cm, bottom: 1.8cm)
#let date-col = 3.8cm
#let gutter = 0.7cm
#let header-height = if photo != none { 5.6cm } else { 5cm } // room for the photo

// ---------------------------------------------------------------------------
// Helpers

#let labels = (
  cv: (en: "Curriculum Vitae", de: "Lebenslauf"),
  profile: (en: "Profile", de: "Profil"),
  experience: (en: "Work Experience", de: "Berufserfahrung"),
  education: (en: "Education", de: "Ausbildung"),
  volunteering: (en: "Voluntary Experience", de: "Ehrenamtliches Engagement"),
  languages: (en: "Languages", de: "Sprachen"),
  skills: (en: "Skills", de: "Kenntnisse"),
  present: (en: "today", de: "heute"),
  until: (en: "until", de: "bis"),
)
#let label(key) = labels.at(key).at(lang)

// A value is localised if it is a map whose keys are all language codes.
#let is-localized(v) = (
  type(v) == dictionary and v.len() > 0 and v.keys().all(k => k in langs)
)
#let t(v) = if is-localized(v) { v.at(lang, default: v.at("en")) } else { v }
// Prose fields are Typst markup, e.g. _italic_.
#let md(v) = eval(t(v), mode: "markup")

#let fmt-date(d) = {
  if d == "present" { return label("present") }
  let parts = str(d).split("-")
  if parts.len() == 1 { return parts.at(0) }
  let sep = if lang == "de" { "." } else { "/" }
  parts.at(1) + sep + parts.at(0)
}

#let fmt-range(item) = {
  let from = item.at("from", default: none)
  let to = item.at("to", default: none)
  if from == none and to == none { none }
  else if from == none { label("until") + " " + fmt-date(to) }
  else if to == none or to == from { fmt-date(from) }
  else { fmt-date(from) + " – " + fmt-date(to) }
}

// Left-column text: primary labels (dates, names) in ink, secondary in muted.
#let meta(body, fill: muted) = text(font: mono, size: meta-size, fill: fill, hyphenate: false, body)

// Grid cells align at the top of the first line (its cap height), so smaller
// left-column text sits higher than the body text next to it. Push it down by
// the cap-height difference so both first lines share a baseline.
#let on-baseline(body, font: mono, size: meta-size) = context {
  let cap(font, size) = measure(text(font: font, size: size, "X")).height
  pad(top: cap(sans, body-size) - cap(font, size), body)
}

#let bullet(body) = grid(
  columns: (0.9em, 1fr),
  box(square(size: 3pt, fill: accent-deco), baseline: -1.9pt), body,
)

// Glued to the preceding item (non-breaking space) so a wrapped line never
// starts with a separator.
#let dot = text(fill: accent-deco, weight: "bold", sym.space.nobreak + "· ")

// Two-column row: meta (dates, labels) on the left, content on the right.
#let rows(..cells) = grid(
  columns: (date-col, 1fr),
  column-gutter: gutter,
  row-gutter: 0.5em,
  ..cells,
)

// ---------------------------------------------------------------------------
// Components

#let section(key, body) = {
  block(sticky: true, above: 1.6em, below: 0.9em, grid(
    columns: (date-col, 1fr),
    column-gutter: gutter,
    align: horizon,
    line(length: 100%, stroke: 2pt + accent-deco),
    text(size: 12pt, weight: "semibold", fill: accent, label(key)),
  ))
  body
}

// (left, right) pair for a list item; left is none unless the item has a date.
#let item-row(it) = {
  if type(it) == dictionary and not is-localized(it) {
    (on-baseline(meta(fmt-range(it))), bullet(md(it.text)))
  } else {
    (none, bullet(md(it)))
  }
}

// Grid cells for one role: its date on the left, title and details on the right.
#let role-cells(r, gap: 0pt) = {
  let body = ()
  for line in r.at("body", default: ()) { body.push((none, md(line))) }
  for it in r.at("items", default: ()) { body.push(item-row(it)) }
  for g in r.at("groups", default: ()) {
    body.push((none, text(fill: muted, style: "italic", t(g.label))))
    for it in g.items { body.push(item-row(it)) }
  }

  let cells = (
    pad(top: gap, on-baseline(meta(fmt-range(r), fill: ink))),
    pad(top: gap, text(weight: "semibold", md(r.role))),
  )
  for (left, right) in body {
    cells.push(if left == none { [] } else { left })
    cells.push(right)
  }
  cells
}

// Every entry is a company followed by one or more roles. Left column:
// location, then each role's date. Right column: company, then each role.
// A single role can sit directly on the entry; several go under `roles`.
#let entry(e) = {
  let roles = e.at("roles", default: (e,))
  let cells = ()
  if "org" in e {
    let loc = if "location" in e { text(size: 8pt, fill: muted, hyphenate: false, t(e.location)) } else { [] }
    let org = {
      text(weight: "medium", t(e.org))
      if "note" in e {
        linebreak()
        text(size: 8pt, fill: muted, md(e.note))
      }
    }
    cells += (on-baseline(loc, font: sans, size: 8pt), org)
  }
  for (i, r) in roles.enumerate() {
    cells += role-cells(r, gap: if i == 0 { 0.15em } else { 0.7em })
  }

  block(breakable: false, below: 1.3em, rows(..cells))
}

// Brand icon from icons/ (Simple Icons, CC0), recoloured and sized to the text.
#let icon(name, fill) = box(baseline: 0.12em, image(
  bytes(read("icons/" + name + ".svg").replace("<svg ", "<svg fill=\"" + fill.to-hex() + "\" ")),
  format: "svg",
  height: 0.9em,
))

#let header() = context {
  let content-x = margin.x + date-col + gutter
  let c = contact-data
  let contact-text = text.with(size: 8pt, fill: white.transparentize(25%))
  let sep = text(fill: accent-light, "  ·  ")

  let contact = ()
  if "phone" in c { contact.push(link("tel:" + c.phone.replace(" ", ""), c.phone)) }
  contact += (
    link("mailto:" + c.email, c.email),
    link("https://github.com/" + c.github, [#icon("github", accent-light) GitHub]),
    link("https://www.xing.com/profile/" + c.xing, [#icon("xing", accent-light) Xing]),
  )
  // Address lines (private CV only) go on one line above the contact links.
  let address = if "address" in c { c.address.map(t).join(sep) } else { none }

  place(top + left, dx: -margin.x, dy: -margin.top, block(
    width: page.width,
    height: header-height,
    fill: header-fill,
    {
      // Photo spans exactly the date column, so its edges line up with the
      // section rules below.
      if photo != none {
        place(left + horizon, dx: margin.x, box(
          radius: 3pt,
          clip: true,
          image(photo, width: date-col, height: date-col * 1.17, fit: "cover"),
        ))
      }
      place(left + horizon, dx: content-x, stack(
        text(font: mono, size: 8pt, fill: accent-light, tracking: 0.08em, upper(label("cv"))),
        v(0.9em),
        text(font: "Inter Display", size: 26pt, weight: "bold", fill: white, tracking: -0.02em, data.person.name),
        v(0.7em),
        text(size: 11pt, fill: accent-light, t(data.person.title)),
        v(1.4em),
        ..if address != none { (contact-text(address), v(0.6em)) },
        contact-text(contact.join(sep)),
      ))
    },
  ))
  v(header-height - margin.top + 0.4cm)
}

// ---------------------------------------------------------------------------
// Document

#set document(
  title: data.person.name + " – " + label("cv"),
  author: data.person.name,
  keywords: (label("cv"), "v" + version, build-date.display()),
)
#set page(
  paper: "a4",
  margin: margin,
  footer: context meta(rows(
    counter(page).display("1 / 1", both: true),
    data.person.name + " · " + label("cv"),
  )),
)
// German needs hyphenation for its long compounds; English reads better without.
#set text(font: sans, size: body-size, fill: ink, lang: lang, hyphenate: lang == "de")
#set par(leading: 0.6em)

#header()

#section("profile", rows([], md(data.profile)))

#section("experience", for e in data.experience { entry(e) })

#section("education", for e in data.education { entry(e) })

#section("volunteering", for e in data.volunteering { entry(e) })

#section("languages", rows(
  ..data.languages.map(l => (on-baseline(meta(t(l.name), fill: ink)), t(l.level))).flatten(),
))

#section("skills", rows(
  ..data.skills.map(s => (on-baseline(meta(t(s.group), fill: ink)), s.items.map(i => box(t(i))).join(dot))).flatten(),
))
