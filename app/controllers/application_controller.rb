
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/index' do
    redirect to "/articles"
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/new" do
    @article = Article.new
    erb :new
  end

  post "/articles" do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles"
  end


end


#continually got an error that said something like "failure to find field 'title' that is not disabled."
#viewed the solution and began copy/pasting the files in the solution into my file and then running "learn"
#after each paste, to test which file the error was in and figure out why it was happening.
#Even the solution files themselves won't work however. My terminal is in the correct directory. Everything should work.
#My gut says that there was an error in creating the table but rolling back and running a migration doesn't fix it. The field does exist 
#in my erb file, and it isn't disabled. No idea why capybara isn't reading it.

#I'm out of ideas. Capybara tests won't pass. 

#on closer inspection I think it might be a problem with my settings on visual studio. My schema is crossed out and has a D next to it
#tried deleting and re-migrating to create a schema that isn't broken, but the program won't let me.
#submitting exercise because I know how to do all the steps, but don't have time to debug.


#I found the error! I had moved on from this but discovered that I had two folders with exactly the same name for this lab, which shouldn't even be possible.
#I was in the directory of the other one and running those tests.
#Renaming that folder seems to have fixed the problem.
#It's an error that could only happen to me. I'm still absolutely confused as to how two folders could have the same exact directory in my system.
#It feels like something must have been critically broken.
