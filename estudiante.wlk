import materiaAprobada.*
import carrera.*

class Estudiante {
  const property nombre
  const property apellido
  const property materiasAprobadas = new Set()
  const property carrerasInscripto = new Set()
  
  method registrarMateriaAprobada(_materia, _nota) {
    self.validarAprobacion(_materia, _nota)
    
    materiasAprobadas.add(new MateriaAprobada(materia = _materia, nota = _nota))
  }
  
  method validarAprobacion(materia, nota) {
    if (self.aprobo(materia)) self.error("La materia ya ha sido aprobada")
    if (nota < 4) self.error("La nota mínima para aprobar es 4")
  }
  
  method inscribirACarrera(carrera) {
    if (self.estaInscriptoEnCarrera(carrera)) self.error(
        "El estudiante ya se encuentra inscripto en la carrera"
      )
    
    carrerasInscripto.add(carrera)
  }
  
  method estaInscriptoEnCarrera(carrera) = carrerasInscripto.contains(carrera)
  
  method aprobo(materia) = materiasAprobadas.any(
    { materiaAprobada => materiaAprobada.materia() == materia }
  )
  
  method cantidadMateriasAprobadas() = materiasAprobadas.size()
  
  method promedio() {
    if (not self.aproboMaterias()) self.error(
        "No se puede calcular el promedio de notas sin materias aprobadas"
      )
    
    return materiasAprobadas.average(
      { materiaAprobada => materiaAprobada.nota() }
    )
  }
  
  method aproboMaterias() = not materiasAprobadas.isEmpty()
  
  method materiasDeCarrerasInscripto() = carrerasInscripto.flatMap(
    { carreraInscripto => carreraInscripto.materias() }
  )
}