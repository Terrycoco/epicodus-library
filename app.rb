require './lib/author.rb'
require './lib/book.rb'
require 'sinatra/reloader'
require 'sinatra'
also_reload '../lib/**/*.rb'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  @catalog = Book.all()
  erb(:index)
end

post('/books') do
  title = params.fetch('title')
  genre = params.fetch('genre')
  new_book = Book.new({:title => title, :genre => genre, :id => nil})
  new_book.save()
  @catalog = Book.all()
  erb(:index)
end

get('/books/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:book)
end
