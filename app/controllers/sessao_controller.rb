class SessaoController < ActionController::Base
  layout "login"

  def index
  end

  def login
    create
  end

  def create
    usu = params[:usu]
    login = usu[:login]
    senha = usu[:senha]
    retorno = Cliente.valida(login, senha)
    if retorno[:status] == "ok"
      iniciar_sessao(retorno)
      session[:expires_at] = 10.minutes.from_now
      respond_to do |format|
        format.html { redirect_to action: :show, id: session[:usuario_id], controller: :clientes, msn: {mensagem: retorno[:msn], type: "success"} }
      end
    else
      msn = ""
      msn = retorno[:msn]
      usu = nil
      respond_to do |format|
        format.html { redirect_to :msn => {mensagem: msn, type: "danger"}, :action => "index", :controller => "sessao" }
      end
    end
  end

  def sessao_externa
    usu = JSON.parse(params['usuario'])
    login = usu['login']
    senha = usu['senha']
    sis = JSON.parse(params['sistema'])
    retorno = Usuario.valida(login, senha, sis)
    respond_to do |format|
      format.json { render json: retorno }
    end
  end

  def iniciar_sessao(resp)
    usuario_corrente = resp[:usuario]
    session[:usuario_id] = usuario_corrente[:id]
    session[:usuario_desc] = usuario_corrente[:nome]
    session[:usuario_email] = usuario_corrente[:email]
  end

  def logout
    session[:usuario_id] = nil
    session[:usuario_email] = nil
    session[:usuario_desc] = nil
    reset_session
    redirect_to :action => "index", :controller => "sessao"
  end
end