#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :session_expiry
  before_action :update_activity_time
  before_action :valida_classes_metodos

  public

  def session_expiry
    expire_time = session[:expires_at] || Time.now
    session_time_left = (expire_time - Time.now).to_i
    unless session_time_left > 0
      resetar_sessao
      msn = 'Sessão Expirou'
      redirect_to :msn => {mensagem: msn, type: "danger"}, :action => "index", :controller => "sessao"
    end
  end

  def resetar_sessao
    session[:usuario_id] = nil
    session[:usuario_desc] = nil
    session[:usuario_email] = nil
    reset_session
  end

  def update_activity_time
    session[:expires_at] = 60.minutes.from_now
  end

  def valida_classes_metodos
    if (action_name == 'new' || action_name == 'edit' || action_name == 'create' || action_name == 'update' || action_name == 'destroy')
      case controller_name
      when 'transferencias'
        if params[:tipo] == 'transferência' || params[:tipo] == 'saque'
          cliente = Cliente.find(Conta.find(params[:cliente_id]).cliente_id)
        else
          cliente = Cliente.find(session[:usuario_id])
        end
      when 'contas'
        cliente = Cliente.find(Conta.find(params[:id]).cliente_id)
      else
        cliente = Cliente.find(params[:id])
      end
      if (cliente.email != session[:usuario_email])
        flash[:alert] = 'Acesso não permitido'
        redirect_to controller: :clientes, action: :show, id: session[:usuario_id]
      end
    end
  end
end
