require 'pry'

class Team

  attr_reader :sms, :task_list, :all
  def initialize(&block)
    @all = []
    @sms = {}
    instance_eval &block
  end

  def priority(*list)
    @list = list
  end

  def on_task(type, &block)
    @sms[type] = block
  end


  def add_task(task)
    dev = @all.
    sort_by { |dev| [dev.task_list.size, @list.index(dev.type.to_s.insert(-1, 's').to_sym)] }.first
    dev.task_list << task    
    if @sms[dev.type].nil?
      raise 'нет агрумента для блока'
    else
     @sms[dev.type].(dev, task)
   end
 end


 def report
  @all.sort_by{|i| [i.task_list.size, @list.index(i.type)]}.each do |dev|
    puts "#{dev.name} (#{to_sumb(dev.type)}): #{dev.task_list.join(', ')}"
  end



  def make_developer(type, name)
    type.new(name)
  end

  private  

  def to_sumb(name)
    name.to_s.chop.to_sym
  end

  def have_seniors(*names)
    @seniors = names
    @all.push(@seniors.
      map!{|name| make_developer(SeniorDeveloper, name)}).flatten!
  end

  def have_developers(*names)
    @developers = names
    @all.push(@developers.
      map!{|name| make_developer(Developer, name)}).flatten!
  end

  def have_juniors(*names)
    @juniors = names
    @all.push(@juniors.
      map!{|name| make_developer(JuniorDeveloper, name)}).flatten!
  end
end

class Developer

  MAX_TASKS = 10

  attr_reader :task_list, :name, :type

  def initialize(name)
    @name = name
    @task_list = []
    @type = type
  end

  def add_task(task)
    @task = task
    if @task_list.count >= self.class::MAX_TASKS
      raise ArgumentError, "Слишком много работы!"
    end
    @task_list.push task
    puts %Q{%s: добавлена задача "%s". Всего в списке задач: %s}%
    [@name, task, @task_list.count]
  end
  
  def work!
    if @task_list.empty?
      raise ArgumentError, "Нечего делать!"
    end
    puts %Q{%s: выполнена задача "%s". Всего в списке задач: %s}%
    [@name, @task_list.shift, @task_list.count]
  end

  def tasks
    @task_list.each_with_index.map{|a, i| "#{i+1}. #{a}"}.join("\n")
  end

  def can_add_task?
    @task_list.count < self.class::MAX_TASKS
  end

  def can_work?
    @task_list.any?
  end

  def status
    case 
    when @task_list.empty?
      'свободен'
    when @task_list.count > 0 && @task_list.count < self.class::MAX_TASKS
      'работаю'
    when @task_list.count == self.class::MAX_TASKS
      'занят'
    end
  end

  def type
    :developer
  end
end

class SeniorDeveloper < Developer

  MAX_TASKS = 15

  # attr_reader :task_list

  def work!
    if @task_list.empty?
      raise ArgumentError, "Нечего делать!"
    end
    x = rand(2)
    if x.zero? && @task_list.count == 1     
      puts %Q{%s: выполнена задача "%s". Всего в списке задач: %s}%
      [@name, @task_list.shift, @task_list.count] 
    elsif x.zero? && @task_list.count > 1
      puts %Q{%s: выполнена задача "%s". Всего в списке задач: %s}%
      [@name, @task_list.shift, @task_list.count] 
      puts %Q{%s: выполнена задача "%s". Всего в списке задач: %s}%
      [@name, @task_list.shift, @task_list.count] 
    else
      puts "Что-то лень"
    end
  end

  def type
    :senior
  end
end

class JuniorDeveloper < Developer

  MAX_TASKS = 5

  # attr_reader :task_list

  def add_task(task)
    @task = task
    if @task.length > 20
      raise ArgumentError, "Слишком сложно!"
    end
    super
  end

  def work!
    if @task_list.empty?
      raise ArgumentError, "Нечего делать!"
    end
    puts %Q{%s: пытаюсь делать задачу "%s". Всего в списке задач: %s}%
    [@name, @task_list.shift, @task_list.count]
  end

  def type
    :junior
  end
end

binding.pry

