include BCrypt

get '/login' do
  erb :"login/index"
end

post '/login' do
  @user = User.authenticate(params[:username], params[:password])
  p "*" * 100
  p @user
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :"login/index"
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/login'
end
