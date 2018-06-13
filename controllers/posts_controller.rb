class PostsController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end


  #Set the root as the parent directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  #Set the view directory correctly
  set :views, Proc.new {File.join(root, "views")}

  $posts = [
    {
      :id => 0,
      :title => "Post 1",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 1,
      :title => "Post 2",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    },
    {
      :id => 2,
      :title => "Post 3",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
  ]

  get "/" do

    @title = "Posts Index"
    @posts = $posts # Bringing in our global variable as a local varibale

    erb :"posts/index"
  end

  #New
  get "/new" do

    @post = {
      :id => "",
      :title =>"",
      :body =>""
    }

    erb :"posts/new"
  end

  get "/:id" do

    id = params[:id].to_i

    @title = 'Show Post'
    @post = $posts[id]

    erb :"posts/show"
  end

  # create
  post '/' do
    # puts params

    id = $posts.last[:id] + 1

    new_post = {
      :id => id,
      :title => params[:title],
      :description => params[:description]
    }

    $posts.push new_post

    redirect '/'
    # puts new_post
  end

  # UPDATE
  put '/:id' do
    #Get id from params
    id = params[:id].to_i

    #Get hash from array
    post = $posts[id]

    #Update the necessary hash with the values from the params
    post[:title] = params[:title]
    post[:body] = params[:body]

    # Save the new data back in our array
    $posts[id] = post

    redirect '/'

  end

  get "/:id/edit" do

    id = params[:id].to_i
    "Edit page for #{ :id }"
    @post = $posts[id]

    erb :"posts/edit"

  end

  #Destroy
  delete "/:id" do
    id = params[:id].to_i

    $posts.delete_at id

    redirect '/'
  end

end
