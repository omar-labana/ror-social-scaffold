require 'rails_helper'

RSpec.describe 'friendship model associations', type: :system do
  before(:each) do
    User.create(name: 'omar',
                email: 'omar@mero.com',
                gravatar_url: '123456789',
                password: '123456789', password_confirmation: '123456789')

    User.create(name: 'ramo',
                email: 'ramo@mero.com',
                gravatar_url: '123456789',
                password: '123456789', password_confirmation: '123456789')
  end

  it 'adds a user to your friend list' do
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'omar@mero.com'
    fill_in 'Password', with: '123456789'
    click_button 'Log in'
    expect(page).to have_content('Invite to friendship')
  end

  it 'removes a user from your friend list' do
    Friendship.safe_create(User.first.id, User.second.id)
    Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'omar@mero.com'
    fill_in 'Password', with: '123456789'
    click_button 'Log in'
    expect(page).to have_content('End friendship')
  end

  it 'shows a call to action button when no friendship' do
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'omar@mero.com'
    fill_in 'Password', with: '123456789'
    click_button 'Log in'
    expect(page).to have_content('Invite to friendship')
  end

  it 'accepts an invitation' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'omar@mero.com'
    fill_in 'Password', with: '123456789'
    click_button 'Log in'
    expect(page).to have_content('Accept')
  end

  # same as test 2
  it 'end friendship' do
    Friendship.safe_create(User.second.id, User.first.id)
    visit "#{root_path}users/#{User.second.id}"
    fill_in 'Email', with: 'omar@mero.com'
    fill_in 'Password', with: '123456789'
    click_button 'Log in'
    click_link 'Accept'
    expect(page).to have_content('End friendship')
  end
end
