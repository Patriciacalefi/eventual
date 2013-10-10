class ApuracaosController < ApplicationController
  # GET /apuracaos
  # GET /apuracaos.xml
  before_filter :load_resources
  before_filter :load_disciplinas
  def index
      if params[:search].blank?
          @search = Apuracao.search(params[:search])
          @apuracaos = @search.paginate(:page=>params[:page],:per_page =>1000, :order => "total DESC")
      else
          @search = Apuracao.search(params[:search])
          @apuracaos = @search.paginate(:all,:page=>params[:page],:per_page =>1000, :order => "total DESC")
      end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apuracaos }
    end

  end

  

  # GET /apuracaos/1
  # GET /apuracaos/1.xml
  def show
    @apuracao = Apuracao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apuracao }
    end
  end

  # GET /apuracaos/new
  # GET /apuracaos/new.xml
  def new
    @apuracao = Apuracao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apuracao }
    end
  end

  # GET /apuracaos/1/edit
  def edit
    @apuracao = Apuracao.find(params[:id])
  end

  def impressao_classificacao
      @apuracaos = Apuracao.all(:conditions => ["ativo = 1 and disciplina = ?",params[:search]], :order => "nome")
      render :layout => "impressao"
  end


  # POST /apuracaos
  # POST /apuracaos.xml
  def create
    @apuracao = Apuracao.new(params[:apuracao])

    respond_to do |format|
      if @apuracao.save
        if logged_in?
          @apuracao.gera_log(current_user.id, "Apuração de inscrição efetuada")
        end
        flash[:notice] = 'Apuracao was successfully created.'
        format.html { redirect_to(@apuracao) }
        format.xml  { render :xml => @apuracao, :status => :created, :location => @apuracao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apuracao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apuracaos/1
  # PUT /apuracaos/1.xml
  def update
    @apuracao = Apuracao.find(params[:id])

    respond_to do |format|
      if @apuracao.update_attributes(params[:apuracao])
        if logged_in?
          @apuracao.gera_log(current_user.id, "Atualização de apuração de inscrição efetuada")
        end
        flash[:notice] = 'Apuracao was successfully updated.'
        format.html { redirect_to(@apuracao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apuracao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apuracaos/1
  # DELETE /apuracaos/1.xml
  def destroy
    @apuracao = Apuracao.find(params[:id])
    if logged_in?
      @apuracao.gera_log(current_user.id, "Exclusão de apuração efetuada")
    end
    @apuracao.destroy

    respond_to do |format|
      format.html { redirect_to(apuracaos_url) }
      format.xml  { head :ok }
    end
  end

  def seleciona_curso
    if params[:sel_curso].to_s == "TODOS"
      @inscritos = Formulario.all(:include => :apuracao,:conditions => ["ativo = 1 and documentacao_entregue = 1 and id not in (select formulario_id from apuracaos)"])
    else
      @inscritos = Formulario.all(:include => :apuracao,:conditions => ["disciplina = ? and ativo = 1 and documentacao_entregue = 1 and id not in (select formulario_id from apuracaos)", params[:sel_curso]])
    end
    render :update do |page|
      page.replace_html 'filtrado', :partial => "inscritos"
    end

  end

  def classificacao
#    if params[:search][:curso_equals] == "TODOS"
#      @search = Apuracao.search(:all)
#    else
      @search = Apuracao.search(params[:search])
#    end
  if params[:search].present?
    @apuracao = @search.all(:order => "total DESC")
     ## Gera arquivo em xls
     @ap = Apuracao.all(:conditions => ["curso like ?","%" + params[:search][:curso_equals].to_s + "%"])
     @report = DailyOrdersXlsFactory.new("simple report")
     @report.add_column(10).add_column(40).add_column(30)
     @report.add_row(["Prefeitura Municipal de Americana"], 30).join_last_row_heading(0..3)
     @report.add_row([params[:search][:curso_equals]], 30).join_last_row_heading(0..3)
     @report.add_row(["Classificação","Nome"])
     classificacao = 1
     @ap.each do |ap|
       @report.add_row([classificacao,ap.formulario.nome])
       classificacao = classificacao + 1
     end
     @report.save_to_file("public/saidas/#{current_user.login}_#{Date.today.strftime("%d_%m_%Y")}_#{params[:search][:curso_equals]}.xls")
  end

  end


 def listagem
   send_file("#{RAILS_ROOT}/public/saidas/#{current_user.login}_#{Date.today.strftime("%d_%m_%Y")}_#{params[:curso]}.xls")
 end


  def inscrito
    begin
      inscricao = Formulario.find(params[:inscrito])
      @formulario = @apuracao = Apuracao.find_by_formulario_id(inscricao.id)
    rescue
      erro = "Apuração ainda não existe. Crie uma nova"
    ensure
      unless @apuracao.present?
        @apuracao = Apuracao.new
        redirect_to new_apuracao_path
      else
        redirect_to edit_apuracao_path(@apuracao, :formulario => inscricao)
      end      
    end

  end


  protected

  def load_resources
    @inscritos = Formulario.all(:conditions => ["ativo = 1 and documentacao_entregue = 1"],:order => 'nome ASC')
  end
  
  def load_disciplinas
      @disciplinas = Disciplina.find(:all, :order => 'disciplina ASC')
  end
end
