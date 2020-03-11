
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  post '/articles' do
    # Create the new article (or fetch it if it already exists)
    article = Article.find_or_create_by(params)
    # Redirect to display the article
    redirect "/articles/#{article.id}"
  end
  
  get '/articles/new' do
    # Render the create new article view
    erb :new  
  end

  get '/articles/:id' do
    # Display to requested article
    @article = Article.find(params[:id])
    erb :show
  end

  patch '/articles/:id' do
    # Fetch the article to be updated
    @article = Article.find(params[:id])
    # Update the article
    @article.update(title: params[:title], content: params[:content])
    # Display the updated article
    redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    # Fetch the article to delete
    article = Article.find(params[:id])
    # Delete the article
    article.destroy
    # Redirect to the index of articles
    redirect '/articles'
  end

  get '/articles/:id/edit' do
    # Fetch the article to be edited
    @article = Article.find(params[:id])

    # Renders the view to edit the specified article
    erb :edit
  end

end
