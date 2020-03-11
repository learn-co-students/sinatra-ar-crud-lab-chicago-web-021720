
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
  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params[:id])
    erb :edit
  end

  post '/create' do
    newarticle = Article.new(
      title: params[:title],
      content: params[:content]
    );
    newarticle.save
    redirect "/articles/#{newarticle.id}"
  end

  patch '/articles/:id' do
    params.delete("_method")
    @article = Article.find_by(id: params[:id])
    @article.update(params)
    erb :show
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])

    redirect '/articles'
  end
end
