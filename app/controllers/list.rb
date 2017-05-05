#show all lists
get '/lists' do
  user = User.find(session[:user_id])
  @lists = user.lists.sort_by{|list| list.tier}
  erb :'lists/index'
end

#new
get '/lists/new' do
  @list = List.new
  erb :'lists/new'
end

post '/lists' do
  @list = List.new(params[:list])
  @list.user_id = session[:user_id]
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
  user = User.find(session[:user_id])
  @list = List.find(params[:id])
  redirect '/lists' unless user.lists.include? @list
  if request.xhr?
    erb :'lists/_index', layout: false, locals: {list: @list}
  else
    erb :'lists/show'
  end
end

#edit
get '/lists/:id/edit' do
  user = User.find(session[:user_id])
  @list = List.find(params[:id])
  redirect '/lists' unless user.lists.include? @list
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
  user = User.find(session[:user_id])
  @list = List.find(params[:id])
  redirect '/lists' unless user.lists.include? @list
  @list.destroy!
  redirect '/lists'
end
