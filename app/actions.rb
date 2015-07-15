# Homepage (Root path)
configure do
  enable :sessions
  # set :username, 'frank' 
  # set :password, 'sinatra'
end

get '/' do
  erb :index
end

get '/view' do
  @songs = Song.all
  #@songs = Song.joins('LEFT OUTER JOIN  upvotes ON upvotes.song_id = songs.id').group('songs.id').select('songs.*, COUNT(upvotes.song_id) as votes')
#song.votes
  # @songs = Song.joins('LEFT OUTER JOIN upvotes ON upvotes.song_id = songs.id GROUP BY songs.id')
  #binding.pry
  erb :view
end

get '/create' do
  erb :create
end

post '/create' do
  #binding.pry
  @song = Song.new(
    title: params[:title],
    artist:  params[:artist],
    user_id: session[:user_id]
  )
  @song.save
  redirect '/view'
end

get "/signup" do
  erb :signup
end

post '/signup' do
  #binding.pry
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password:  params[:password]
  )
  @user.save
  redirect '/'
end

get '/login' do
  erb :login
end

post '/login' do
  # binding.pry
  if User.find_by(name: params[:username], password: params[:password])  
    @current_user_id = User.find_by(name: params[:username], password: params[:password]).id
    session[:user] = params[:username] 
    session[:user_id] = @current_user_id
    redirect to('/view')
  else
    erb :login
  end 
end

get '/logout' do
  @current_user_id = nil
  session.clear
  redirect to('/login')
end

get '/upvote' do
end

post '/upvote' do
  #binding.pry
  if session[:user_id]
    Upvote.create(
      user_id: session[:user_id],
      song_id: params[:song_id]
    )
  end

  redirect to('/view')
end

def count_upvotes

end

# get '/songs' do
#   halt 401, 'go away!' unless session[:user]
#   "You are logged in #{session[:user]}!"
# end

# Cookies
 
# get '/' do
#   response.set_cookie("hey", :value => "ya")
#   cookie = request.cookies["my_cookie"]
#   "Cookie set. Would you like to <a href='/read'>read it</a>?"
# end
 
# get '/read' do
#   "Cookie value: #{request.cookies['hey']}."
# end
 
# get '/delete' do 
#   response.delete_cookie "hey" "Cookie has been deleted."
#   response.set_cookie("hey", :value => "changed")
# end