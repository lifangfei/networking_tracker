get '/session-viewer' do
  session.inspect
end

get '/' do
  @user = User.new
  @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
  if !!session[:user_id]
    user = User.find(session[:user_id])
    # test
    # user.interactions.first.update({follow_up: Date.today.to_s})
    @interactions = user.interactions.where({follow_up: Date.today.to_s})
    if @interactions.length > 0
      connections = @interactions.map {|interaction| interaction.connection.full_name}
      connections = connections.join(", ")
      @client.messages.create(
        from: '+14085604374',
        to:   "#{user.phone_number}",
        body: "Remember to follow up with #{connections}"
      )
    end
  end
  erb :'index'
end

#new
get '/users/new' do
  @user = User.new
  if request.xhr?
    erb :'users/_front_page_signup', layout: false
  else
    erb :'users/new'
  end
end

#create
post '/users' do
  @user = User.new(params[:user])
  @user.password = params[:user][:password_hash]
  @user.password_hash = @user.password
  @user.save!
  if @user.valid?
    redirect "/sessions/new"
  else
    status 422
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

#show
get '/users/:id' do
  redirect '/sessions/new' unless session[:user_id] == params[:id].to_i
  @user = User.find(params[:id])
  erb :'users/show'
end

#edit
get '/users/:id/edit' do
  redirect '/sessions/new' unless session[:user_id] == params[:id].to_i
  @user = User.find(params[:id])
  erb :'users/edit'
end

#update
def update_user
  @user = User.find(params[:id])
  @user.update(params[:user])
  if @user.valid?
    redirect "/users/#{@user.id}"
  else
    status 422
    @errors = @user.errors.full_messages
    erb :'users/edit'
  end
end

patch '/users/:id' do
  update_user
end

put '/users/:id' do
  update_user
end

#delete
delete '/users/:id' do
  User.find(params[:id]).destroy!
  redirect '/users'
end

