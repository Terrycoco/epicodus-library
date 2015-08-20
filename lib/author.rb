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

end
