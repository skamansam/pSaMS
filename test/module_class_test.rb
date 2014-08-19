Dir.glob './files/*\.rb' do |file|

  require file
  file=~/(\w+)\.rb$/
  sc = $1.camelize.constantize.new()
  sc.a()
end
