#show all connection
get '/connections' do
  erb :'connections/index'
end

#new
get '/connections/new' do
  @connection = Connection.new
  erb :'connections/new'
end

#create
post '/connections' do
  @connection = Connection.new(params[:connection])
  @connection.password = params[:password_hash]
  @connection.save!
  if @connection.valid?
    redirect '/connections'
  else
    status 422
    @errors = @connection.errors.full_messages
    erb :'connections/new'
  end
end

#show
get '/connections/:id' do
  redirect '/login' unless session[:connection_id] == params[:id].to_i
  @connection = Connection.find(params[:id])
  erb :'connections/show'
end

#edit
get '/connections/:id/edit' do
  redirect '/login' unless session[:connection_id] == params[:id].to_i
  @connection = Connection.find(params[:id])
  erb :'connections/edit'
end

#update
def update_connection
  @connection = Connection.find(params[:id])
  @connection.update(params[:connection])
  if @connection.valid?
    redirect "/connection/#{@connection.id}"
  else
    status 422
    @errors = @connection.errors.full_messages
    erb :'connections/edit'
  end
end

patch '/connections/:id' do
  update_connection
end

put '/connections/:id' do
  update_connection
end

#delete
delete '/connections/:id' do
  Connection.find(params[:id]).destroy!
  redirect '/connections'
end

