# Homepage (Root path)
get '/' do
  erb :index
end

get '/view' do
  @songs = Song.all
  erb :view
end

get '/create' do
  erb :create
end

post '/create' do
  #binding.pry
  @song = Song.new(
    title: params[:title],
    artist:  params[:artist]
  )
  @song.save
  redirect '/view'
end
