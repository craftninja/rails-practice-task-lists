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
    if page.has_content?("2 days")
      expect(page).to have_content("2 days")
    else
      expect(page).to have_content("3 days")
    end
  end

  scenario 'Task lists with no tasks say \'nothing here to see\'' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Nothing here to see!")
  end

  scenario 'User must fill in task description' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "Add Task"
    fill_in "Description", with: ""
    today = Time.now.to_date
    year = today.to_s[0..3]
    month = today.to_s[5..6]
    day = today.to_s[8..9]
    select(year, :from => "task[due_date(1i)]")
    select(month, :from => "task[due_date(2i)]")
    select(day, :from => "task[due_date(3i)]")
    click_on "Create Task"
    expect(page).to have_content("Your task could not be created")
  end


end
