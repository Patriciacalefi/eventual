class FormulariosController < ApplicationController
  require_role ["rh","administrador"], :for => [:destroy,:update,:index,:listagem_por_curso]
  before_filter :load_disciplinas1
  before_filter :load_disciplinas2
  before_filter :load_disciplinas3
  before_filter :load_disciplinas4
  before_filter :load_disciplinas5
  before_filter :load_disciplinas6
  before_filter :load_disciplinas7
  before_filter :load_disciplinas8
  before_filter :load_disciplinas

  def load_disciplinas
      @disciplinas = Disciplina.find(:all, :order => 'disciplina ASC')
  end
  def load_disciplinas1
      @disciplinas1 = Disciplina.find(:all, :conditions => ['opcao=?','MAGISTÉRIO'])
  end
  def load_disciplinas2
      @disciplinas2 = Disciplina.find(:all, :conditions => ['opcao=?','PEDAGOGIA'])
  end
  def load_disciplinas3
      @disciplinas3 = Disciplina.find(:all, :conditions => ['opcao=?','EDUCAÇÃO ESPECIAL'])
  end
  def load_disciplinas4
      @disciplinas4 = Disciplina.find(:all, :conditions => ['opcao=?','ARTES'])
  end
  def load_disciplinas5
      @disciplinas5 = Disciplina.find(:all, :conditions => ['opcao=?','EDUCAÇÃO FÍSICA'])
  end
  def load_disciplinas6
      @disciplinas6 = Disciplina.find(:all, :conditions => ['opcao=?','HISTÓRIA'])
  end
  def load_disciplinas7
      @disciplinas7 = Disciplina.find(:all, :conditions => ['opcao=?','GEOGRAFIA'])
  end
  def load_disciplinas8
      @disciplinas8 = Disciplina.find(:all, :conditions => ['opcao=?','LETRAS'])
  end
  def load_disciplinas8
      @disciplinas9 = Disciplina.find(:all, :conditions => ['opcao=?','MATEMÁTICA'])
  end
 def classificacao
#    if params[:search][:curso_equals] == "TODOS"
#      @search = Apuracao.search(:all)
#    else
      @search = Formulario.search(params[:search])
#    end

   t=0
  if params[:search].present?

    @apuracao = @search.all(:conditions => ["ativo = 0 AND documentacao_entregue = 1"],:order => "total DESC, dt_nasc, n_filhos DESC")
     ## Gera arquivo em xls
     #@ap = Apuracao.all(:conditions => ["curso like ?","%" + params[:search][:curso_equals].to_s + "%"])
     @ap=@search.all(:conditions => ["ativo = 0 AND documentacao_entregue = 1"],:order => "total DESC, dt_nasc, n_filhos DESC")

     @report = DailyOrdersXlsFactory.new("simple report")
     @report.add_column(18).add_column(12).add_column(40).add_column(30)
     @report.add_row(["PREFEITURA MUNICIPAL DE AMERICANA"], 30).join_last_row_heading(0..3)
     @report.add_row(["SERETARIA DE EDUCAÇÃO"], 30).join_last_row_heading(0..3)
     @report.add_row(["Classificação Profesores Eventuais"], 20).join_last_row_heading(0..3)
     @report.add_row([params[:search]], 20).join_last_row_heading(0..2)
     @report.add_row(["CLASSIFICAÇÃO","INSCRIÇÃO","NOME", "DISCIPLINA"],30)
     classificacao = 1
     @ap.each do |ap|
       @report.add_row([classificacao,ap.id,ap.nome,ap.disciplina.disciplina])
       classificacao = classificacao + 1
     end
     @report.save_to_file("public/saidas/#{current_user.login}_#{Date.today.strftime("%d_%m_%Y")}_#{params[:search][:curso_equals]}.xls")
  else
    @apuracao = Formulario.all(:conditions => ["ativo = 0 AND documentacao_entregue = 1" ],:order => "total DESC, dt_nasc, n_filhos DESC")
   end
  end


  def seleciona
    $opcao = params[:formulario_opcao]
    render :partial => 'selecao_disciplina'
    end


 def listar_nota
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:conditions => ["ativo = 0"],:order => 'nome ASC')
      else
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:conditions => ["ativo = 0"],:order => 'nome ASC')
      end
  end

  def listar_nota_curso
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:conditions => ["ativo = 0"],:order => "total DESC")
      else
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:conditions => ["ativo = 0"],:order => "total DESC")
      end
  end

  def index
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => 'nome ASC')
      else
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => 'nome ASC')
      end
  end

 def nota
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:conditions => ["ativo = 0"], :order => 'nome ASC')
      else
          @search = Formulario.search(params[:search])
         @formularios = @search.all( :conditions => ["ativo = 0"], :order => 'nome ASC')
      end
  end


  def apuracao_nota
    @formulario = Formulario.find(params[:id])
  end

  def show
    @formulario = Formulario.find(params[:id])
  end

  def completa
    @formulario = Formulario.find(params[:id])
  end

  def new
    @formulario = Formulario.new
  end

  def create
    @formulario = Formulario.new(params[:formulario])
    teste= @formulario.exerce_funcao
    if teste==true
      render :action => 'naoautorizado'
    else

        if @formulario.save
          if logged_in?
            @formulario.gera_log(current_user.id, "Inscrição efetuada")
          end
          Notificador.deliver_email_geral(@formulario)
          flash[:notice] = "INSCRIÇÂO EFETUADA COM SUCESSO."
          redirect_to @formulario
        else
          render :action => 'new'
        end
   end
  end

  def edit
    @formulario = Formulario.find(params[:id])
  end

  def update
    @formulario = Formulario.find(params[:id])
    if @formulario.update_attributes(params[:formulario])
    if logged_in?
      @formulario.gera_log(current_user.id, "Atualização de inscrição efetuada")
    end
      flash[:notice] = "INSCRIÇÃO SALVA."
      redirect_to @formulario
    else
      render :action => 'edit'
    end
  end

  def destroy
    @formulario = Formulario.find(params[:id])
    if logged_in?
      @formulario.gera_log(current_user.id, "Exclusão de inscrição efetuada")
    end
    @formulario.destroy
    flash[:notice] = "Successfully destroyed formulario."
    redirect_to formularios_url
  end

  def listagem_por_curso
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => "nome")
      else
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => "nome")
      end
  end

  def impressao
      @formularios = Formulario.all(:conditions => ["ativo = 1 and disciplina = ?",params[:search]], :order => "nome")
      render :layout => "impressao"
  end

  def ativo
    @formularios = Formulario.all(:conditions => ["documentacao_entregue = 1"], :order => "nome ASC")
  end

  def cancelados
    if params[:nome].present?
      @formularios = Formulario.all(:conditions => ["(ativo = 1) and nome like ?", "%"+params[:nome]+"%"], :order => "nome ASC")
    else
      @formularios = Formulario.all(:conditions => ["ativo = 1"], :order => "nome ASC")
    end
  end

  def sem_documentos
    if params[:nome].present?
      @formularios = Formulario.all(:conditions => ["(ativo = 0) and S(documentacao_entregue = 0) and nome like ?", "%"+params[:nome]+"%"], :order => "nome ASC")
    else
      @formularios = Formulario.all(:conditions => ["ativo = 0 and documentacao_entregue = 0"], :order => "nome ASC")
    end
  end

def edital
   render 'edital'
end


  def iformulario
      if params[:search].blank?
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => 'nome ASC')
      else
          @search = Formulario.search(params[:search])
          @formularios = @search.all(:order => 'nome ASC')
      end
  end



def iformulario_imp
  @formulario = Formulario.find(params[:id])  end


def download_edital
    send_file("#{RAILS_ROOT}/public/documentos/edital.doc" , :type=>"text/msword")
  end
end