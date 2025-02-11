#!/usr/bin/python3
"""
Script that retrieves TODO list progress for a given employee ID
using a REST API
"""
import requests
import sys


def get_employee_todo_progress(employee_id):
    """
    Retrieves the TODO list progress for a specific employee.
    Args:
        employee_id: Integer ID of the employee
    Returns:
        None (prints the progress to stdout)
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"
    
    # Get employee information
    user_url = f"{base_url}/users/{employee_id}"
    user_response = requests.get(user_url)
    user_data = user_response.json()
    
    # Get TODO list for employee
    todos_url = f"{base_url}/todos?userId={employee_id}"
    todos_response = requests.get(todos_url)
    todos_data = todos_response.json()
    
    # Calculate progress
    total_tasks = len(todos_data)
    done_tasks = len([task for task in todos_data if task.get('completed')])
    employee_name = user_data.get('name')
    
    # Print progress information
    print(f"Employee {employee_name} is done with tasks({done_tasks}/{total_tasks}):")
    
    # Print completed tasks
    for task in todos_data:
        if task.get('completed'):
            print(f"\t {task.get('title')}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 0-gather_data_from_an_API.py <employee_id>")
        sys.exit(1)
        
    try:
        employee_id = int(sys.argv[1])
        get_employee_todo_progress(employee_id)
    except ValueError:
        print("Error: Employee ID must be an integer")
        sys.exit(1)
