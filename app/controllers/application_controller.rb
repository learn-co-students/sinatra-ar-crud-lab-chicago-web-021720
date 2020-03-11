
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  # new
  get '/articles/new' do
    erb :new
  end

  # show specific book
  get '/articles/:id' do

    article_by_id
    erb :show
  end

  # create
  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
    p params
    #erb :show
  end

  get '/articles' do
    p params
    @articles = Article.all
    erb :index
  end


  get '/articles/:id/edit' do
    article_by_id
    erb :edit
  end
  # update
  patch '/articles/:id' do
    article_by_id
    @article.update(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
    #erb :show
  end

  #delete
  delete '/articles/:id' do
    article_by_id
    @article.destroy
    redirect '/articles'
  end

  def article_by_id
    @article = Article.find(params[:id])
  end

end
