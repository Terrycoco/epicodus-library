require('book')
require('rspec')
require('pg')
require('author')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM authors_books *;")
  end
end

describe(Book) do
  describe('#initialize') do
    it('creates a book and returns title') do
      new_book = Book.new({:title => 'A Christmas Carol',  :genre => 'classics', :id => nil})
      new_book.save()
      expect(new_book.title()).to(eq('A Christmas Carol'))
    end
  end

  # describe('#add_author') do
  #   it('adds an author to the authors property of the book') do
  #     new_author = Author.new({:lastname => 'Smith', :firstname => 'John', :author_id => nil})
  #     new_author.save()
  #     new_book = Book.new({:title => 'Tale of Two Cities',  :genre => 'great lit', :book_id => nil, :authors => []})
  #     new_book.save()
  #     new_book.add_author(new_author)
  #     expect(new_book.authors().include?(new_author)).to(eq(true))
  #   end
  # end

  # describe('.all') do
  #   it('should be empty at first') do
  #     expect(Book.all()).to(eq([]))
  #   end
  #
  #   #we need to test a return of a filled books array next
  # end




end
