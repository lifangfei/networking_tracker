include BCrypt

get '/sessions/new' do
  if request.xhr?
    erb :"sessions/_front_page_login", layout: false
  else
    erb :"sessions/index"
  end
end

post '/sessions' do
  @user = User.authenticate(params[:username], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :"sessions/index"
  end
end

get '/logout' do
  session.delete(:user_id)
  redirect '/'
end
