class Developer

	MAX_TASKS = 10

	def initialize(name)
		@name = name
		@task_list = []
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
end

class SeniorDeveloper < Developer

	MAX_TASKS = 15

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
end

class JuniorDeveloper < Developer

	MAX_TASKS = 5

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
end
