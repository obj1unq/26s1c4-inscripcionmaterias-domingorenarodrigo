class Materia {
  const property requisitos = new Set()
  
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
}