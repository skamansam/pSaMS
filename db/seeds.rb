# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
if RACK_ENV =~ /test/
  email = 'admin@nowhere.org'
  password = 'test123'
else
  email     = shell.ask 'Which email do you want use for logging into admin?'
  password  = shell.ask 'Tell me the password to use:'
end

shell.say ''

account = Account.create(
  email: email,
  name: 'Admin',
  surname: 'User',
  password: password,
  password_confirmation: password,
  role: 'admin'
)

if account.valid?
  shell.say '================================================================='
  shell.say 'Account has been successfully created, now you can login with:'
  shell.say '================================================================='
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say '================================================================='
else
  shell.say 'Sorry but something went wrong!'
  shell.say ''
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say "\nNow we need a first post to get started."
if RACK_ENV =~ /test/
  title = 'Welcome to my Site!'
  body = 'This is the default post'
else
  title = shell.ask 'What is the title of your first post?'
  body = shell.ask 'Now give me some content for the first post:'
end

Post.create!(
  title: title,
  body: body,
  account_id: account.id,
  category: Category.create!(name: 'home_page')
)
