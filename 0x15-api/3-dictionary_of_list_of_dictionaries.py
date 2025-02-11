#!/usr/bin/python3
"""
Script that exports TODO list data for all employees to JSON format
"""
import json
import requests


def export_all_todos_to_json():
    """
    Exports the TODO list data for all employees to JSON format.
    Returns:
        None (creates a JSON file)
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com"
    
    # Get all users
    users_url = f"{base_url}/users"
    users_response = requests.get(users_url)
    users_data = users_response.json()
    
    # Get all todos
    todos_url = f"{base_url}/todos"
    todos_response = requests.get(todos_url)
    todos_data = todos_response.json()
    
    # Prepare JSON structure
    json_data = {}
    
    # Group todos by user ID
    for user in users_data:
        user_id = str(user.get('id'))
        user_todos = [
            task for task in todos_data
            if task.get('userId') == user.get('id')
        ]
        
        json_data[user_id] = [
            {
                "username": user.get('username'),
                "task": task.get('title'),
                "completed": task.get('completed')
            }
            for task in user_todos
        ]
    
    # Write to JSON file
    with open('todo_all_employees.json', 'w') as json_file:
        json.dump(json_data, json_file)


if __name__ == "__main__":
    export_all_todos_to_json()
