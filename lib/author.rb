class Author
  attr_reader :firstname, :lastname, :id

  define_method(:initialize) do |attributes|
    @firstname = attributes.fetch(:firstname)
    @lastname = attributes.fetch(:lastname)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result_set = DB.exec("INSERT INTO authors (firstname, lastname) VALUES ('#{@firstname}','#{lastname}') RETURNING author_id;")
    @id = result_set.first().fetch("author_id")
  end

  define_singleton_method(:all) do
    authors = []
    result_set = DB.exec("SELECT * FROM authors;")
    result_set.each() do |row|
      firstname = row.fetch('firstname')
      lastname = row.fetch('lastname')
      id = row.fetch('author_id')
      new_author = Author.new({:firstname => firstname, :lastname => lastname, :id => id})
      authors.push(new_author)
    end
    authors
  end

  
end
