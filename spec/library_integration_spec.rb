require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a book', {:type => :feature}) do
  it('opens with a list of all books and allows user to add a book') do
    visit('/')
    fill_in('title', :with => 'Catcher in the Rye')
    fill_in('genre', :with => 'Classics')
    click_button("Add Book")
    expect(page).to have_content('Catcher in the Rye')
  end
end

describe('view details about an individual book', {:type => :feature}) do
  it('allows user to click on individual book link and view details about that book') do
    visit('/')
    fill_in('title', :with => 'Animal Farm')
    fill_in('genre', :with => 'Classics')
    click_button("Add Book")
    click_link('Animal Farm')
    expect(page).to have_content('Classics')
  end
end

describe('how to update details about a book', {:type => :feature}) do
  it('allows user to update details about a book') do
    visit('/')
    fill_in('title', :with => 'Animal Farms')
    fill_in('genre', :with => 'Classics')
    click_button("Add Book")
    click_link('Animal Farms')
    click_link('Edit Book')
    fill_in('title', :with => 'Animal Farm')
    click_button('Save')
    expect(page).to have_content('Animal Farm')
  end
end

describe('how to delete a book', {:type => :feature}) do
  it('allows user to delete a book') do
    visit('/')
    fill_in('title', :with => 'Animal Farms')
    fill_in('genre', :with => 'Classics')
    click_button("Add Book")
    click_link('Animal Farms')
    click_link('Delete Book')
    expect(page).should_not have_content('Animal Farms')
  end
end
