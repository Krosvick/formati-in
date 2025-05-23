/// Get state which keeps track of numbering patterns.
///
/// - label (label): the label which is used for document fences
/// - numbering (array): the default numberings to start with
/// - alignments (array): the default alignments to start with
/// -> counter
#let numbering-state(
  label: <anti-matter:fence>,
  numbering: ("I", "1", "I"),
  alignments: (center, right, center),
) = state("anti-matter:state", (
  label: label,
  numbering: numbering,
  alignments: alignments,
))

/// Get the counter which keeps track of the inner page number.
///
/// -> counter
#let inner-counter() = counter("anti-matter:inner-counter")

/// Get the counter which keeps track of the outer page number.
///
/// -> counter
#let outer-counter() = counter("anti-matter:outer-counter")

/// Retreive the part at the given location.
///
/// - loc (location): the location at which to get the part for
/// -> str
#let part(loc) = {
  let label = numbering-state().at(loc).label
  let fences = query(label, loc)

  let fence-1 = fences.first().location()
  let fence-2 = fences.last().location()

  if loc.page() <= fence-1.page() {
    "front"
  } else if fence-1.page() < loc.page() and loc.page() <= fence-2.page() {
    "inner"
  } else {
    "back"
  }
}

/// Select the counter and numbering index for the given part.
///
/// - part (str): the part for which to get the numbering for (must be one of `front`, `inner`,
///   `back`)
/// -> (array, none)
#let select(part) = (
  front: (outer-counter(), 0),
  inner: (inner-counter(), 1),
  back: (outer-counter(), 2),
).at(part, default: none)
