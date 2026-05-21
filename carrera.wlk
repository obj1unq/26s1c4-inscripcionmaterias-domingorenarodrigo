class Carrera {
  const property materias = new Set()

  method agregar(materia) {
    if (self.esParteDelPlan(materia)) self.error(
      "La materia ya es parte del plan de estudios de la carrera"
    )

    materias.add(materia)
  }

  method esParteDelPlan(materia) = materias.contains(materia)
}