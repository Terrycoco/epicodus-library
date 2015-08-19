class Book
  attr_reader(:title, :genre, :book_id, :authors)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @genre = attributes.fetch(:genre)
    @book_id = attributes.fetch(:book_id)
    @authors = attributes.fetch(:authors)
  end

  define_method(:save) do
    result_set = DB.exec("INSERT INTO book (title, genre) VALUES ('#{@title}','#{@genre}') RETURNING book_id;")
    @book_id = result_set.first().fetch('book_id').to_i()
  end

  define_method(:add_author) do |new_author|
    authorid = new_author.author_id()
    DB.exec("INSERT INTO book_author (book_id, author_id) VALUES (#{@book_id}, #{authorid});")
    @authors.push(new_author)
  end

  define_singleton_method(:all) do
    books = []
    result_set = DB.exec("select * from book;")

    # double check syntax
    if !result_set.num_tuples.zero?
      result_set.each() do |row|
        title = row.fetch('title')
        genre = row.fetch('genre')
        book_id = row.fetch('book_id').to_i()

        #fetch the authors into authors array
        authors = []
        rs = DB.exec("SELECT author.author_id, author.firstname, author.lastname from author, book_author
             WHERE author.author_id = book_author.author_id
             AND book_author.book_id = #{book_id};")

        rs.each() do |row|
          firstname = rs.fetch('firstname')
          lastname = rs.fetch('lastname')
          author_id = rs.fetch('author_id')
          new_author = Author.new({:firstname => firstname, :lastname => lastname, :author_id => author_id})
          authors.push(new_author)
        end

        new_book = Book.new({:title => title, :genre => genre, :book_id => book_id, :authors => authors})
        books.push(new_book)

      end
    end
    return books
  end

end
