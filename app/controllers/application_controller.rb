
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  def find_article(params)
    @article = Article.all.select {|art| art.id == params[:id].to_i}[0]
  end
  get "/" do
  end

  get "/articles/new" do 
    erb :new
  end

  post "/articles" do 
    @article = Article.new
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect "/articles/#{@article.id}"
    #binding.pry
    #erb :show
  end

  get "/articles/:id" do
    @article = find_article(params)
    #binding.pry
    erb :show
  end

  get "/articles" do 
    @articles = Article.all
    erb :index
  end

  get "/articles/:id/edit" do
    @article = find_article(params)
    erb :edit
  end

  patch "/articles/:id" do
    @article = find_article(params)
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show
  end

  delete "/articles/:id" do
    @article = find_article(params)
    @article.destroy
  end

end
