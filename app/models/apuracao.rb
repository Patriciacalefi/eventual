class Apuracao < ActiveRecord::Base
  belongs_to :formulario
  before_save :gera_total
  before_create :salva_curso
  attr_accessor :sel_curso
  def divulga_status
    if self.aprovada == true
      "Aprovada"
    else
      "Reprovada"
    end
  end

  def gera_log(usuario,acao)
    log = Log.new
      log.acao = acao
      log.formulario_id = self.id
      log.user_id = usuario
    log.save
  end

  protected

  def gera_total
    self.total = self.nota_prova + self.n_pontos
  end

  def salva_curso
    self.curso = self.formulario.disciplina
  end

end
