class Paciente {
  var edad
  var nivelDeFortaleza
  var dolor
  const rutina = []

  method edad() = edad
  method dolor() = dolor
  method nivelDeFortaleza() = nivelDeFortaleza


  method cargarRutina(unaLista) {
    rutina.clear()
    rutina.addAll(unaLista)
  }

  method cumplirAnios() {
    edad += 1
  }

  method disminuirDolor(unValor) {
    dolor -= unValor
  }

  method aumentarFortaleza(unValor) {
    nivelDeFortaleza = (nivelDeFortaleza + unValor)
  }

  method puedeUsar(unAparato) = unAparato.puedeSerUsadoPor(self)

  method usar(unAparato) {
    if (self.puedeUsar(unAparato))
     { unAparato.consecuenciaDelUso(self)}
  }

  method puedeHacerRutina() =
    rutina.all {a => self.puedeUsar(a)}
  

  method realizarRutina() {
    rutina.forEach( {a => self.usar(a)})
  }

}

class Resistente inherits Paciente {
  override method realizarRutina() {
    super() // realiza primero la rutina como la describe el super
    self.aumentarFortaleza(
      rutina.count {a => self.puedeUsar(a)}) // aca estaria el override
  }

}

class Caprichoso inherits Paciente {
  override method puedeHacerRutina() {
    return self.hayAparatoRojo() and super()
  }
  method hayAparatoRojo() {
    return rutina.any {a => a.color() == "rojo"}
  }
  override method realizarRutina() {
    super() 
    super()
  }
}

class RapidaRec inherits Paciente {
  override method realizarRutina() {
    super()
    self.disminuirDolor(disminucionDolor.valor())
  }
}

object disminucionDolor {
  var property valor = 3 
}

class Aparato {
  var property color = "blanco" 
  method consecuenciaDelUso(unPaciente)
  method puedeSerUsadoPor(unPaciente)
}

class Magneto inherits Aparato{
  override method consecuenciaDelUso(unPaciente) {
    unPaciente.disminuirDolor(
      unPaciente.dolor() * 0.1
    )
  }
  override method puedeSerUsadoPor(unPaciente) = true
}

class Bici inherits Aparato{
  override method consecuenciaDelUso(unPaciente) {
    unPaciente.disminuirDolor(4)
    unPaciente.aumentarFortaleza(3)
}
  override method puedeSerUsadoPor(unPaciente) {
    return unPaciente.edad() > 8 
  }
}

class Minitramp inherits Aparato{
  override method consecuenciaDelUso(unPaciente) {
    unPaciente.aumentarFortaleza(
      unPaciente.edad() * 0.1
    )
  }
  override method puedeSerUsadoPor(unPaciente) {
    return unPaciente.dolor() < 20
  }
}

