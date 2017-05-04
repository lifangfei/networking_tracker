#new
get '/interactions/new' do
  @interaction = Interaction.new
  erb :'interactions/new'
end

#create
post '/interactions' do
  @interaction = Interaction.new(params[:interaction])
  @interaction.password = params[:password_hash]
  @interaction.save!
  if @interaction.valid?
    redirect '/interactions'
  else
    status 422
    @errors = @interaction.errors.full_messages
    erb :'interactions/new'
  end
end

#show
get '/interactions/:id' do
  # redirect '/sessions/new' unless session[:interaction_id] == params[:id].to_i
  @interaction = Interaction.find(params[:id])
  erb :'interactions/show'
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

