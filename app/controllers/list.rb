#show all lists
get '/lists' do
  erb :'lists/index'
end

#new
get '/lists/new' do
  @list = List.new
  erb :'lists/new'
end

post '/lists' do
  @list = List.new(params[:list])
  @list.password = params[:password_hash]
  @list.save!
  if @list.valid?
    redirect '/lists'
  else
    status 422
    @errors = @list.errors.full_messages
    erb :'lists/new'
  end
end

#show
get '/lists/:id' do
  redirect '/login' unless session[:list_id] == params[:id].to_i
  @list = List.find(params[:id])
  erb :'lists/show'
end

#edit
get '/lists/:id/edit' do
  redirect '/login' unless session[:list_id] == params[:id].to_i
  @list = List.find(params[:id])
  erb :'lists/edit'
end

def update_list
  @list = List.find(params[:id])
  @list.update(params[:list])
  if @list.valid?
    redirect "/lists/#{@list.id}"
  else
    status 422
    @errors = @list.errors.full_messages
    erb :'lists/edit'
  end
end

patch '/lists/:id' do
  update_list
end

put '/lists/:id' do
  update_list
end

#delete
delete '/lists/:id' do
  List.find(params[:id]).destroy!
  redirect '/lists'
end