
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

  describe(:initialize) do
    it('creates a author') do
      new_auth = Author.new({:firstname => 'Charles', :lastname => 'Dickens', :id => nil})
      new_auth.save()
      expect(new_auth.lastname()).to(eq('Dickens'))
    end
  end

end
