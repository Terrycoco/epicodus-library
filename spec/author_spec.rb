
require('rspec')
require('pg')
require('author')

DB = PG.connect({:dbname => 'library_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM authors *;")
  end
end

describe(Author) do

  describe('#initialize') do
    it('creates a author') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      new_auth.save()
      expect(new_auth.lastname()).to(eq('Dickens'))
    end
  end

  describe('.all') do
    it('returns all the authors in database') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('returns true if two ids are equal') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      new_auth2 = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      expect(new_auth).to(eq(new_auth2))
    end
  end

  describe('.find') do
    it('finds an author based on id') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      new_auth2 = Author.new({:firstname => 'Ernest', :lastname => 'Hemmingway', :id => nil})
      new_auth.save()
      new_auth2.save()
      id = new_auth.id()
      expect(Author.find(id)).to(eq(new_auth))
    end
  end

  describe('#update') do
    it('updates values of an author') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dicks', :id => nil})
      new_auth2 = Author.new({:firstname => 'Ernest', :lastname => 'Hemmingway', :id => nil})
      new_auth.save()
      new_auth2.save()
      new_auth.update({:lastname => 'Dickens'})
      expect(new_auth.lastname()).to(eq('Dickens'))
    end
  end

  describe('#delete') do
    it('deletes an author entry') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      new_auth.save()
      new_auth2 = Author.new({:firstname => 'Ernest', :lastname => 'Hemmingway', :id => nil})
      new_auth2.save()
      new_auth.delete()
      expect(Author.all()).to(eq([new_auth2]))
    end
  end


end
