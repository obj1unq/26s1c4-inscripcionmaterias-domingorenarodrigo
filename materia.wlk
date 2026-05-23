class Materia {
  const property requisitos = new Set()
  const property estudiantesInscriptos = new Set()
  const property listaDeEspera = []
  var property cupo = 25
  
  // Materias como requisitos
  method tieneComoRequisito(materia) = requisitos.contains(materia)
  
  method validarAgregacionARequisitos(materia) {
    if (materia == self) self.error(
        "Una materia no puede tenerse a sí misma como requisito para ser cursada"
      )
    
    if (self.tieneComoRequisito(materia)) self.error(
        "La materia ya está entre los requisitos para ser cursada"
      )
  }
  
  method agregarARequisitos(materia) {
    self.validarAgregacionARequisitos(materia)
    
    requisitos.add(materia)
  }
  
  // Estudiantes inscriptos
  method cupo(_cupo) {
    if (_cupo < 1) self.error(
        "El cupo de una materia debe ser mayor o igual a 1"
      )
    
    cupo = _cupo
  }
  
  method tieneCupo() = cupo > self.cantidadInscriptos()
  
  method cantidadInscriptos() = estudiantesInscriptos.size()
  
  method tieneInscripto(estudiante) = estudiantesInscriptos.contains(estudiante)
  
 method puedeInscribir(estudiante) {
    return
      estudiante.planesDeCarrerasInscripto().contains(self)
        &&
      not estudiante.aprobo(self)
        &&
      not self.tieneInscripto(estudiante)
        &&
      estudiante.aproboTodas(requisitos)
  }
  
  method validarInscripcion(estudiante) {
    if (not self.puedeInscribir(estudiante)) self.error(
        "No se puede inscribir al estudiante en la materia. Por favor, revisar que cumpla con las condiciones de inscripción."
      )
  }
  
  method inscribir(estudiante) {
    self.validarInscripcion(estudiante)
    
    if (self.tieneCupo()) estudiantesInscriptos.add(estudiante)
    else listaDeEspera.add(estudiante)
  }
}