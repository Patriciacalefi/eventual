class Formulario < ActiveRecord::Base
  ESTADO_CIVIL = %w(SOLTEIRO(A) CASADO(A) VIÚVO(A) SEPARADO(A) DIVORCIADO(A) OUTRO(A))
  DISCIPLINA = ['PROFESSORA DE CRECHE','PEB1 - INFANTIL','PEB1 - FUNDAMENTAL','PEB - EDUCAÇÃO ESPECIAL','PEB2 - PORTUGUES','PEB2 - MATEMATICA','PEB2 - CIENCIAS','PEB2 - HISTORIA','PEB2 - GEOGRAFIA','PEB2 - INGLES','PEB2 - ARTE EDUCACAO','PEB2 - EDUCACAO FISICA']
  OPCAO = ['Selecione','MAGISTÉRIO', 'PEDAGOGIA', 'EDUCAÇÃO ESPECIAL', 'ARTES', 'EDUCAÇÃO FÍSICA', 'HISTORIA', 'GEOGRAFIA', 'LETRAS']
  STATUS = {'ENTREGUE' => 1, 'FALTA DOCUMENTACAO' => 0}
  has_many :graducaos, :dependent => :destroy
  belongs_to:disciplina
  has_one :apuracao, :dependent => :destroy
  validates_presence_of :dt_nasc, :nome, :endereco, :cpf, :rg, :cep, :email, :disciplina_id, :horario, :telefone, :celular, :pis, :estado_civil, :cidade
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_uniqueness_of :cpf, :message => ' - ESTE CPF JÁ POSSUI INSCRIÇÃO'
  attr_accessor :ddd_celular,:ddd_telefone, :telefone_numero, :celular_numero
  before_save :gera_total

  def outra_funcao
    if self.exerce_funcao
      "SIM"
    else
      "NÃO"
    end
  end

  def status
    if self.ativo
      "Cancelado"
    else
      "Valida"
    end
  end

  def documentacao
    if self.documentacao_entregue
      "OK"
    else
      "Não entregue"
    end
  end

  def compose_nome
    "#{self.nome}"
  end

  def gera_log(usuario,acao)
    log = Log.new
      log.acao = acao
      log.formulario_id = self.id
      log.user_id = usuario
    log.save
  end

  def gera_total
    self.total = self.nota_prova + self.n_pontos
  end

  protected
  def compose_celular
    self.celular = "(#{self.ddd_celular})#{self.celular_numero}"
  end
  def compose_telefone
    self.telefone = "(#{self.ddd_telefone})#{self.telefone_numero}"
  end

def before_save
    self.nome.upcase!
    self.endereco.upcase!
    self.complemento.upcase!
    self.bairro.upcase!
    self.cidade.upcase!

end


end
