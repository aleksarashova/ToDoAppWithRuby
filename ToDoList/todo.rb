$tasks = {}
$next_id = 1

def add(title)
  id = $next_id
  $tasks[id] = { title: title, done: false, created_at: Time.now.strftime("%d/%m/%Y %H:%M") }
  $next_id += 1
  puts "Added a new task: [#{id}] [#{title}]"
end

def delete(id)
  task = $tasks.delete(id)
  if task
    puts "Deleted task: [#{id}] [#{task[:title]}]"
  else
    puts "No tasks with id: [#{id}]."
  end
end

def list
  if $tasks.empty?
    puts "Nothing to do ;)"
  else
    $tasks.each do |id, task|
      status = task[:done] ? '[x]' : '[ ]'
      puts "#{id}. #{task[:title]} (from #{task[:created_at]}) #{status}"
    end
  end
end

def pending
  results = $tasks.select { |id, task| task[:done] == false }

  if results.empty?
    puts "No pending tasks ;)"
  else
    results.each do |id, task|
      puts "#{id}. #{task[:title]} (from #{task[:created_at]})"
    end
  end
end

def complete(id)
  task = $tasks[id]
  if task
    task[:done] = true
    puts "Completed task: [#{id}] [#{task[:title]}]"
  else
    puts "No tasks with id: [#{id}]."
  end
end

def menu
  puts "1. add task\n2. delete task\n3. see tasks\n4. complete task\n5. see pending tasks\n6. exit"
end

puts "Welcome to ToDo List"

loop do
  puts "Options: "
  menu

  print "your choice: "
  opt = gets&.chomp&.strip
  break if opt.nil? || opt == "6"

  case opt
  when "1"
    print "title: "
    title = gets&.chomp&.strip
    add(title)
  when "2"
    print "id of task to delete: "
    id = gets&.chomp&.strip.to_i

    if id =~ /^\d+$/
        delete(id.to_i)
    else
        puts "Please enter a valid number."
    end
  when "3"
    puts "---- Existing tasks ----"
    list
  when "4"
    print "id of completed task: "
    id = gets&.chomp&.strip.to_i
    
    if id =~ /^\d+$/
        complete(id.to_i)
    else
        puts "Please enter a valid number."
    end
  when "5"
    puts "---- Pending tasks ----"
    pending
  else
    puts "Invalid option."
  end
end

puts "Bye!"