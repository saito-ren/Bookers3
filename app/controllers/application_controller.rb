class ApplicationController < ActionController::Base
# before_actionをApplicationControllerに定義することで、ApplicationControllerを継承しているコントローラー内の全てのアクションが実行される前に、before_actionが実行される
#ログイン済みユーザーにのみアクセスを許可(ログインしていない場合はログイン画面にリダイレクトする) 
 # before_action :authenticate_user!

# deviseにまつわる画面に行った時に、という意味がある。こうすることで全ての画面でconfigure_permitted_parametersをするのを防いでいる
before_action :configure_permitted_parameters, if: :devise_controller?
protect_from_forgery with: :exception

	 # ログイン後の挙動
	def after_sign_in_path_for(resource)
		user_path(resource)
	end
	# ログアウトの後の挙動
	def after_sign_out_path_for(resource)
		root_path
	end
    
    protected
	def configure_permitted_parameters
		# deviseで設定されているstrong_parametersに対してパラメーターを追加することができる
		devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :name])
		devise_parameter_sanitizer.permit(:sign_in, keys:[:name])
	end
end
