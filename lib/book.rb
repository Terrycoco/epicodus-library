class Book
  attr_reader(:title, :genre, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @genre = attributes.fetch(:genre)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result_set = DB.exec("INSERT INTO books (title, genre) VALUES ('#{@title}','#{@genre}') RETURNING book_id;")
    @id = result_set.first().fetch('book_id').to_i()
  end

  define_singleton_method(:all) do
    books = []
    result_set = DB.exec("SELECT * FROM books;")
    result_set.each() do |row|
      title = row.fetch("title")
      genre = row.fetch("genre")
      id = row.fetch("book_id").to_i()
      new_book = Book.new({:title => title,  :genre => genre, :id => id})
      books.push(new_book)
    end
    books
  end

  define_method(:==) do |another_book|
    self.id().==(another_book.id())
  end

  define_singleton_method(:find) do |param_id|
    result_set = DB.exec("SELECT * from books where book_id = #{param_id};")
    title = result_set.first().fetch("title")
    genre = result_set.first().fetch("genre")
    new_book = Book.new({:title => title, :genre => genre, :id => param_id})
    new_book
  end

  define_method(:update) do |fields_to_update|
    @title = fields_to_update.fetch(:title, @title)
    @genre = fields_to_update.fetch(:genre, @genre)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}', genre = '#{@genre}' WHERE book_id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE from books WHERE book_id = #{self.id()};")
  end

end
  #
  # define_method(:add_author) do |new_author|
  #   authorid = new_author.author_id()
  #   DB.exec("INSERT INTO book_author (book_id, author_id) VALUES (#{@book_id}, #{authorid});")
  #   @authors.push(new_author)
  # end
  #
  # define_singleton_method(:all) do
  #
  #
  # end



  #   books = []
  #   result_set = DB.exec("select * from book;")
  #
  #   # # double check syntax
  #   # if !result_set.num_tuples.zero?
  #   #   result_set.each() do |row|
  #   #     title = row.fetch('title')
  #   #     genre = row.fetch('genre')
  #   #     book_id = row.fetch('book_id').to_i()
  #   #
  #   #     #fetch the authors into authors array
  #   #     authors = []
  #   #     rs = DB.exec("SELECT author.author_id, author.firstname, author.lastname from author, book_author
  #   #          WHERE author.author_id = book_author.author_id
  #   #          AND book_author.book_id = #{book_id};")
  #   #
  #   #     rs.each() do |row|
  #   #       firstname = rs.fetch('firstname')
  #   #       lastname = rs.fetch('lastname')
  #   #       author_id = rs.fetch('author_id')
  #   #       new_author = Author.new({:firstname => firstname, :lastname => lastname, :author_id => author_id})
  #   #       authors.push(new_author)
  #   #     end
  #   #
  #   #     new_book = Book.new({:title => title, :genre => genre, :book_id => book_id, :authors => authors})
  #   #     books.push(new_book)
  #   #
  #   #   end
  #   end
  #   return books
  # end
