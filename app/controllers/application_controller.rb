
require_relative '../../config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end 

  post '/articles' do
    @article = Article.create(title: params[:title],content: params[:content])
    redirect "/articles/#{@article.id}"
  end 

  get '/articles' do
    @articles = Article.all
    erb :index
  end 

  get '/articles/:id' do
    find_article
    erb :show
  end 

  get '/articles/:id/edit' do
    find_article
    erb :edit
  end 

  patch '/articles/:id' do
    find_article
    @article.assign_attributes(title: params[:title], content: params[:content])
    @article.save
    redirect "/articles/#{@article.id}"
  end 

  delete '/articles/:id' do 
    find_article    
    @article.destroy
    redirect "/articles"


  end 

  def find_article
    @article = Article.find(params[:id])
  end 


end
