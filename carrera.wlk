class Carrera {
  const property planDeEstudios = new Set()

  method contieneEnElPlan(materia) = planDeEstudios.contains(materia)

  method agregarAlPlan(materia) {
    if (self.contieneEnElPlan(materia)) self.error(
      "La materia ya está contenida en el plan de estudios de la carrera"
    )

    planDeEstudios.add(materia)
  }  
}