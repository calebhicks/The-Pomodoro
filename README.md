The-Pomodoro
============

An iOS pomodoro timer app including history.

### Step 1: move the current work period property 
	- To the project object (remove from viewcontroller)

### Step 2: move the add and remove work period methods
	- To the project object (remove from project controller)
	
### Step 3: Add a "startNewWorkPeriod" and "endCurrentWorkPeriod" to the project object
	- Start new should create a work period
		- Set start time as now
		- Set self.currentWorkPeriod as the one you just created
		- Add it to the work period list 
	- End currentWorkPeriod should set current work period's end time to now
		- then synchronize	
		
### Step 4: Update detail View controller's Start method 
	- It should call it's project's startNewWorkPeriod method
	- Then reload tableviewData
	
### Step 5: Update detail View controller's Finish method 
	- should call it's project's endCurrentWorkPeriod method
	- Then reload tableViewData
	
### Step 6: Update Detail view controller's Add method (big step)
	- It should display a new viewcontroller that let's you set a custom start date and end date
	- Black diamond, don't let the end date be earlier than the start date (fun!)
	- Give them a cancel and save button
		- Save button should create a WorkPeriod object and call [project addWorkPeriod:period]
			
### Step 7: Update tableview after add save
	- When the detail view controller appears it should reload tableview data