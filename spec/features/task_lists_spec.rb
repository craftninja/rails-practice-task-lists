require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")
  end

  scenario 'User can add a task' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "Add Task"
    fill_in "Description", with: "Relax and be happy"
    future_day = Time.now.to_date + 3
    year = future_day.to_s[0..3]
    month = future_day.to_s[5..6]
    day = future_day.to_s[8..9]
    select(year, :from => "task[due_date(1i)]")
    select(month, :from => "task[due_date(2i)]")
    select(day, :from => "task[due_date(3i)]")
    click_on "Create Task"
    expect(page).to have_content("Task was created successfully!")
    expect(page).to have_content("Relax and be happy")
    expect(page).to have_content("2 days")
  end

end
