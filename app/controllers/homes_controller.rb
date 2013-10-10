class HomesController < ApplicationController
  def index
  end

  def buscar
    if params[:search].present?
      @inscricao = Formulario.find(params[:search].to_i)
    end
  end

  def listagem_com_documentos
    send_file("#{RAILS_ROOT}/public/anexo/edital.doc" , :type=>"application/zip")
  end

  def listagem_ativos
    send_file("#{RAILS_ROOT}/public/anexo/RH.zip" , :type=>"application/zip")
  end

  def edital
    send_file("#{RAILS_ROOT}/public/anexo/edital.doc" , :type=>"text/msword")
  end

  def gabarito
    send_file("#{RAILS_ROOT}/public/anexo/GABARITO.pdf" , :type=>"application/pdf")
  end


  def email_geral
    if params[:confirma].present?
      @geral = Formulario.all(:conditions => ["pis like '2147483647'"])
      @geral.each do |z|
        Notificador.deliver_email_geral(z)
      end      
    end
  end

  def busca_cpf
    if params[:search_cpf].present?
      @search = Formulario.all(:conditions => ["cpf like ?",params[:search_cpf]])
    end

  end

  def libera_privacy
    @inscricao = Formulario.find(params[:home][:id], :conditions => ["cpf like ?", params[:home][:cpf]])
    render :update do |page|
        page.replace_html 'private', :partial => "private"
    end

  end

end
