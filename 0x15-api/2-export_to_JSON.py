#!/usr/bin/python3
"""
Script that exports TODO list data for a given employee ID to JSON format
"""
import json
import requests
import sys


def export_todo_to_json(employee_id):
    """
    Exports the TODO list data for a specific employee to JSON format.
    Args:
        employee_id: Integer ID of the employee
    Returns:
        None (creates a JSON file)
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
    
    # Prepare JSON structure
    json_data = {
        str(employee_id): [
            {
                "task": task.get('title'),
                "completed": task.get('completed'),
                "username": user_data.get('username')
            }
            for task in todos_data
        ]
    }
    
    # Write to JSON file
    json_filename = f"{employee_id}.json"
    with open(json_filename, 'w') as json_file:
        json.dump(json_data, json_file)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 2-export_to_JSON.py <employee_id>")
        sys.exit(1)
        
    try:
        employee_id = int(sys.argv[1])
        export_todo_to_json(employee_id)
    except ValueError:
        print("Error: Employee ID must be an integer")
        sys.exit(1)
