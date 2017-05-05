#new
get '/connections/:id/interactions/new' do
  @interaction = Interaction.new
  @connection = Connection.find(params[:id])
  erb :'interactions/new'
end

#create
post '/connections/:id/interactions' do
  @interaction = Interaction.new(params[:interaction])
  @connection = Connection.find(params[:id])
  @interaction.connection_id = params[:id]
  @interaction.save!
  if @interaction.valid?
    redirect '/connections'
  else
    status 422
    @errors = @interaction.errors.full_messages
    erb :"/connections/#{@connection.id}/interactions/new"
  end
end

#show
get '/interactions/:id' do
  # redirect '/sessions/new' unless session[:interaction_id] == params[:id].to_i
  @interaction = Interaction.find(params[:id])
  if request.xhr?
    erb :'interactions/_show', layout: false, locals: {interaction: @interaction}
  else
    erb :'interactions/show'
  end
end

#edit
get '/interactions/:id/edit' do
  # redirect '/login' unless session[:interaction_id] == params[:id].to_i
  @interaction = Interaction.find(params[:id])
  erb :'interactions/edit'
end

#update
def update_interaction
  @interaction = Interaction.find(params[:id])
  @interaction.update(params[:interaction])
  if @interaction.valid?
    redirect "/interactions/#{@interaction.id}"
  else
    status 422
    @errors = @interaction.errors.full_messages
    erb :'interactions/edit'
  end
end

patch '/interactions/:id' do
  update_interaction
end

put '/interactions/:id' do
  update_interaction
end

#delete
delete '/interactions/:id' do
  Interaction.find(params[:id]).destroy!
  redirect '/interactions'
end

