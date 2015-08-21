require('rspec')
require('pg')
require('author')
require('book')


DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE From authors_books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE from books *;")
  end
end

describe(Book) do

describe('#add_author') do
  it('adds an author to a book') do
    new_book = Book.new({:title => 'A Christmas Carol',  :genre => 'classics', :id => nil})
    new_book.save()
    new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
    new_auth.save()
    new_book.add_author(new_auth)
    expect(new_book.authors().include?(new_auth)).to(eq(true))
  end
end

end
