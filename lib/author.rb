class Author
  attr_reader :firstname, :lastname, :author_id

  define_method(:initialize) do |attributes|
    @firstname = attributes.fetch(:firstname)
    @lastname = attributes.fetch(:lastname)
    @author_id = attributes.fetch(:author_id)
  end

  define_method(:save) do
    result_set = DB.exec("INSERT INTO author (firstname, lastname) VALUES ('#{@firstname}','#{@lastname}') RETURNING author_id;")
    @author_id = result_set.first().fetch('author_id').to_i()
  end

end
