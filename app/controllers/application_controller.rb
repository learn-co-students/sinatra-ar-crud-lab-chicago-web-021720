
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get('/') {
        redirect '/articles'
    }

    get('/articles') {
        @articles = Article.all
        erb :index
    }

    get('/articles/new') {
        erb :new
    }

    get('/articles/:id') {
      @article = Article.find(params[:id])
      erb :show
  }

    get('/articles/:id/edit') {
        @article = Article.find(params[:id])
        erb :edit
    }

    post('/articles') {
        p params
        @article = Article.create(params[:article])
        redirect "/articles/#{@article.id}"
    }

    patch('/articles/:id') {
        @article = Article.find(params[:id])
        @article.update(params[:article])
        redirect "/articles/#{@article.id}"
    }

    delete("/articles/:id") {
        Article.find(params[:id]).destroy
        redirect "/articles"
    }

end

# rubocop