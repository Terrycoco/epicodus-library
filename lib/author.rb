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

  define_method(:==) do |another_author|
    self.id().==(another_author.id())
  end

  define_singleton_method(:find) do |id|
    result_set = DB.exec("SELECT * from authors where author_id = #{id};")
      row = result_set.first()
      lastname = row.fetch('lastname')
      firstname = row.fetch('firstname')
      new_auth = Author.new({:lastname => lastname, :firstname => firstname, :id => id})
      new_auth
  end

end
