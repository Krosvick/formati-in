#import "custom_anti_matter/lib.typ": anti-matter, fence, set-numbering, step
#import "@preview/i-figured:0.2.4"

#show: anti-matter

#let to-roman(num) = {
  let numerals = (
    (1000, "M"), (900, "CM"),
    (500, "D"), (400, "CD"),
    (100, "C"), (90, "XC"),
    (50, "L"), (40, "XL"),
    (10, "X"), (9, "IX"),
    (5, "V"), (4, "IV"),
    (1, "I")
  )
  let result = ""
  let n = num
  for (value, symbol) in numerals {
    while n >= value {
      result += symbol
      n -= value
    }
  }
  result
}

// Global heading style rule
#show heading: it => {
  set text(size: 12pt, weight: "bold")
  it
}

#let proyecto(
  titulo: "",
  autor: "",
  profesor_guia: "",
  fecha: "",
  tipo_ingeniero: "INGENIERO CIVIL EN COMPUTACIÓN E INFORMÁTICA",
  body
) = {
  // Configuración de página para la parte pretextual
  set page(
    paper: "us-letter",
    margin: (
      top: 2.8cm,
      bottom: 2.8cm,
      left: 3.3cm,
      right: 3.0cm,
    ),
  )
  
  // Configuración de texto
  set text(
    font: "Times New Roman",
    size: 13pt,
    lang: "es"
  )
  
  // Configuración de párrafos
  set par(
    justify: true,
    leading: 5pt,
    first-line-indent: 0pt
  )
  
  // Configuración de índice de materias
  set outline(
    indent: 1em,
  )
  
  // Configuración de encabezados
  set heading(
    numbering: (..numbers) => {
      let n = numbers.pos()
      if n.len() == 1 {
        text(size: 12pt, weight: "bold")[CAPÍTULO #to-roman(n.at(0)): ]
      } else {
        let chapter = numbers.pos().at(0)
        let section = numbers.pos().slice(1)
        text(size: 12pt)[#numbering("1.1   ", chapter, ..section)]
      }
    },
    supplement: none,
  )
  
  // Configuración de figuras y tablas
  set figure(
    placement: none,
  )
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  
  set table(
    stroke: 0.75pt,
    align: center,
  )
  
  // Página de título
  [
    #set-numbering(none)
    #box(
      stroke: 0.75pt,
      outset: (
        x: 1.3cm,
        y: 2.5cm
      ),
      grid(
        columns: (100%),
        rows: (33%, 34%, 33%),
        {
          grid(
            columns: (100%),
            rows: (auto),
            gutter: 0em,
            v(-2em),
            align(center)[#image("assets/logo_unap.png", width: 40%)],
            align(center)[
              #v(-2em)
              #text()[FACULTAD DE INGENIERÍA Y ARQUITECTURA]
              \
              #text()[INGENIERÍA CIVIL EN COMPUTACIÓN E INFORMÁTICA]
            ],
          )
        },
        {
          grid(
            columns: (100%),
            rows: (50%,50%),
            gutter: 1em,
            {
              v(1em)
              grid(
                columns: (1fr, 1fr),
                rows: (100%),
                grid.cell(
                  colspan: 1,
                  image("assets/logo_icci.png", width: 50%),
                  align: start,
                ),
                grid.cell(
                  colspan: 1,
                  image("assets/acreditada_6.jpg", width: 50%),
                  align: end,
                ),
              )
            },
            {
            align(center)[#set text(hyphenate: false); #text(titulo, weight: "bold", size: 14pt)]
            v(-0.5em)
            align(center)[#text("INTELIGENCIA DE NEGOCIOS")]
            },
            {
              set text(size:10pt)
              align(right)[#set par(leading: 0.5em); #text("INTEGRANTES:", weight: "bold") #text(autor, weight: "bold")]
            },
          )
        },
        {
          v(10em)
          set text(size:10pt)
          align(center)[
            IQUIQUE - CHILE\
            #fecha
          ]
        }
      )
    )
  ]
  pagebreak()
  
  show figure: i-figured.show-figure
  show math.equation: i-figured.show-equation.with(zero-fill: false)

  body
}

#let pretextual-heading(body, is_center: false) = {
  set heading(
    numbering: none,
    outlined: false
  )
  if is_center {
    align(center)[#heading(body)]
  } else {
    heading(body)
  }
}