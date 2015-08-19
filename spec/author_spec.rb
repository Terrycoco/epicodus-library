
require('rspec')
require('pg')
require('author')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM author *;")
  end
end

describe(Author) do

  describe('.find') do |firstname, lastname|
    it('finds the author id based on names and returns author_id') do
      new_a = Author.new({:firstname => 'John', :lastname => 'Steinbeck', :author_id => nil})
      new_b = Author.new({:firstname => 'Charles', :lastname => 'Dickens',:author_id => nil})
      new_a.save()
      new_b.save()
      author_to_find = Author.find_by_name('John', 'Steinbeck')
      expect(author_to_find).to(eq(new_a.author_id()))
    end
  end
end
