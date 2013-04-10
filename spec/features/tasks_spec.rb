require 'spec_helper'

describe "Tasks" do
	before do
		@task = Task.create :task => 'go to bed'
	end

	describe "GET /tasks" do	
		it "display some tasks"	do	
	  		visit tasks_path

	  		page.should have_content 'go to bed'
	  	end  		

	  	it "creates a new task" do
	  		#visit tasks path
	  		visit tasks_path

	  		#Fill in an element which has an id, label or name attribute with 'Task' with some data
	  		fill_in 'Task', :with => "go to work"

	  		#click the button with tasks, post request will be sent to the server
	  		click_button 'Create Task'

	  		#Check the path is equal to the tasks path
	  		current_path.should == tasks_path

	  		#newly created task should have value 'go to work'
	  		page.should have_content 'go to work '	

	  		#finally save and open the page
	  		save_and_open_page
	  	end	

	end

	describe "PUT /tasks" do
	  	it "edits a task" do
	  		#Visit the tasks URL
	  		visit tasks_path

	  		#Click on a link with Edit text
	  		click_link 'Edit'

	  		#current path should be equal to the edit url
	  		current_path.should == edit_task_path(@task)

	  		# page.should have_content == "go to bed"
	  		find_field('Task').value.should == "go to bed"

	  		# Update the task value
	  		fill_in 'Task', :with => "updated task"

	  		# Click the update task button
	  		click_button 'Update Task'

	  		# once saved page should have updated content
	  		page.should have_content 'updated task'
	  	end

	  	it "should not update an empty task" do
	  		visit tasks_path

	  		click_link 'Edit'

	  		fill_in 'Task', :with => ''

	  		click_button 'Update Task'

	  		current_path.should == edit_task_path(@task)

	  		page.should have_content 'There was an error updating task.'
		end
  	end

  	describe "DELETE /tasks" do
  		it "should delete a task" do
  			visit tasks_path
 			find("#task_#{@task.id}").click_link 'Delete'
 			page.should have_content 'Task has been deleted successfully.'
  			page.should have_no_content 'go to bed'
  		end	
  	end
end
