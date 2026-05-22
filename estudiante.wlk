import materiaAprobada.*
import carrera.*

class Estudiante {
  const property materiasAprobadas = new Set()
  const property carrerasInscripto = new Set()
  const property materiasInscripto = new Set()
  
  // Materias Aprobadas
  method aproboMaterias() = not materiasAprobadas.isEmpty()
  
  method cantidadMateriasAprobadas() = materiasAprobadas.size()
  
  method materiasDeMateriasAprobadas() = materiasAprobadas.map(
    { materiaAprobada => materiaAprobada.materia() }
  )
  
  method aprobo(materia) = self.materiasDeMateriasAprobadas().contains(materia)
  
  method aproboTodas(materias) = materias.all(
    { materia => self.aprobo(materia) }
  )
  
  method promedio() {
    if (not self.aproboMaterias()) self.error(
        "No se puede calcular el promedio de notas sin materias aprobadas"
      )
    
    return materiasAprobadas.average(
      { materiaAprobada => materiaAprobada.nota() }
    )
  }
  
  method validarAprobacion(materia, nota) {
    if (self.aprobo(materia)) self.error("La materia ya ha sido aprobada")
    if (nota < 4) self.error("La nota mínima para aprobar es 4")
  }
  
  method registrarMateriaAprobada(_materia, _nota) {
    self.validarAprobacion(_materia, _nota)
    
    materiasAprobadas.add(new MateriaAprobada(materia = _materia, nota = _nota))
  }
  
  // Carreras inscripto
  method estaInscriptoEnCarrera(carrera) = carrerasInscripto.contains(carrera)
  
  method inscribirEnCarrera(carrera) {
    if (self.estaInscriptoEnCarrera(carrera)) self.error(
        "El estudiante ya se encuentra inscripto en la carrera"
      )
    
    carrerasInscripto.add(carrera)
  }
  
  method planesDeCarrerasInscripto() = carrerasInscripto.flatMap(
    { carreraInscripto => carreraInscripto.planDeEstudios() }
  )
  
  // Materias inscripto
  method estaInscriptoEnMateria(materia) = materiasInscripto.contains(materia)
  
  method puedeInscribirseEnMateria(materia) {
    return
      self.planesDeCarrerasInscripto().contains(materia)
        &&
      not self.aprobo(materia)
        &&
      not self.estaInscriptoEnMateria(materia)
        &&
      self.aproboTodas(materia.requisitos())
  }
}

