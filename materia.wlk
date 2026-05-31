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
  
  method tieneEspera() = not listaDeEspera.isEmpty()
  
  method tieneInscripto(estudiante) = estudiantesInscriptos.contains(estudiante)
  
  method tieneEnListaDeEspera(estudiante) = listaDeEspera.contains(estudiante)
  
  method proximoEstudianteEnEspera() {
    if (not self.tieneEspera()) self.error(
        "No hay próximo estudiante en la lista de espera"
      )
    
    return listaDeEspera.first()
  }
  
  method puedeInscribir(estudiante) {
    return
      estudiante.planesDeCarrerasInscripto().contains(self)
        &&
      not estudiante.aprobo(self)
        &&
      not self.tieneInscripto(estudiante)
        &&
      not self.tieneEnListaDeEspera(estudiante)
        &&
      estudiante.aproboTodas(requisitos)
  }
  
  method validarInscripcion(estudiante) {
    if (not self.puedeInscribir(estudiante)) self.error(
        "No se puede inscribir al estudiante en la materia. Por favor, revisar que cumpla con las condiciones de inscripción."
      )
  }
  
  method confirmarInscripcion(estudiante) {
    estudiantesInscriptos.add(estudiante)
  }
  
  method esperarInscripcion(estudiante) {
    listaDeEspera.add(estudiante)
  }
  
  method inscribir(estudiante) {
    self.validarInscripcion(estudiante)
    
    if (self.tieneCupo()) self.confirmarInscripcion(estudiante)
    else self.esperarInscripcion(estudiante)
  }
  
  method inscribirDesdeListaDeEspera() {
    const estudiante = self.proximoEstudianteEnEspera()
    self.cancelarEspera(estudiante)
    self.confirmarInscripcion(estudiante)
  }
  
  method puedeCancelar(estudiante) = 
    self.tieneInscripto(estudiante) || self.tieneEnListaDeEspera(estudiante)
  
  method validarCancelacion(estudiante) {
    if (not self.puedeCancelar(estudiante)) self.error(
        "No se puede dar de baja al estudiante de la materia porque no se encuentra ni inscripto ni en la lista de espera."
      )
  }
  
  method cancelarInscripcion(estudiante) {
    estudiantesInscriptos.remove(estudiante)
    
    if (self.tieneEspera()) self.inscribirDesdeListaDeEspera()
  }
  
  method cancelarEspera(estudiante) {
    listaDeEspera.remove(estudiante)
  }
  
  method cancelar(estudiante) {
    self.validarCancelacion(estudiante)
    
    if (self.tieneInscripto(estudiante)) self.cancelarInscripcion(estudiante)
    else self.cancelarEspera(estudiante)
  }
}