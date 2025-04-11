#import "template.typ": *

#show: anti-matter.with(
  alignments: (center, right, center),
  header: none,
  numbering: ("i", "1", "i")
)
// Empezamos sin numeración para la portada

#show: proyecto.with(
  titulo: "INFORME DE PROYECTO DATAMART",
  autor: "Nombre del Alumno",
  fecha: "2025",
)

// Empezamos con numeración romana para las secciones pretextuales
#set-numbering("i")

// Índices
#pretextual-heading("ÍNDICE DE CONTENIDOS", is_center: true)
#v(1.5em)
#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  it
}
#par(leading:1em)[
#outline(
  title: none,
  target: heading.where(outlined: true)
)
]
#pagebreak()

#pretextual-heading("ÍNDICE DE FIGURAS", is_center: true)
#v(2em)
#i-figured.outline(target-kind: image, title: none)

#pagebreak()

#pretextual-heading("ÍNDICE DE TABLAS", is_center: true)
#v(2em)
#i-figured.outline(target-kind: table, title: none)

#fence()

#pagebreak()


// Capítulos
#include "capitulos/01_introduccion.typ"
#pagebreak()

#include "capitulos/07_conclusiones.typ"
#pagebreak()

#include "capitulos/referencias.typ"
#fence() 