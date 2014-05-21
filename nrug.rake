namespace :nrug do

  desc "Task to run when you want to party on down"
  task :party_here do
    puts fetch(:ping)
    puts "Let's Partay (locally)"
  end

  desc "Task to run when you want to party on down"
  task :party_there do
    on roles(:all) do |host|
      message = capture :echo, "\"lets Partay on\""
      user = capture :whoami
      info "Hi #{user}, #{message} #{capture :hostname}"
    end
  end

  desc "Party all over"
  task :party_down => [:party_here, :party_there] do
    puts "All partied out!"
  end

  desc "Send the users name to the server"
  task :hello_server do
    ask :name, "what's your name?"
    on roles(:all) do |host|
      info "Hello to #{fetch(:name)} from #{capture :hostname}"
    end
  end

  desc "Upload a humans.txt to the server"
  task :upload do
    ask :filename, "What shall I call the file?"
    on roles(:all) do |h|
        file = File.open("humans.txt", "r")
        upload! file, shared_path.join(fetch(:filename))
    end
  end

end