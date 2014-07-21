User.destroy_all
TaskList.destroy_all

user = User.create!(
  name: "Some User",
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)

TaskList.create!(name: "Work List", user_id: user.id)
TaskList.create!(name: "Household Chores", user_id: user.id)
