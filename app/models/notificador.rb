class Notificador < ActionMailer::Base
  def inscricao_eventual(formulario = {})
    recipients formulario.email
    from  "no-reply@seducpma.com"
    subject "Inscrição com sucesso"
    body :formulario => formulario
  end

  def email_geral(inscricao = {})
    recipients inscricao.email
    from  "no-reply@seducpma.com"
    subject "Inscrição com sucesso"
    body :inscricao => inscricao
  end

  def notificar(user)
    recipients user.email
    from  "no-reply@seducpma.com"
    subject "Usuário Cadastrado com sucesso"
    body :user => user
  end

end
