class Book
  attr_reader(:title, :genre, :book_id, :authors)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @genre = attributes.fetch(:genre)
    @book_id = attributes.fetch(:book_id)
    @authors = []
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





end
