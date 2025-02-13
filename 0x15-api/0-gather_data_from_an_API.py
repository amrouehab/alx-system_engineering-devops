#!/usr/bin/python3
"""
Script to fetch and display TODO list progress for a given employee ID using a REST API.
"""

import requests
import sys

def fetch_employee_data(employee_id):
    """Fetch employee and TODO data from the API."""
    base_url = "https://jsonplaceholder.typicode.com"
    user_url = f"{base_url}/users/{employee_id}"
    todos_url = f"{base_url}/users/{employee_id}/todos"

    # Fetch user data
    user_response = requests.get(user_url)
    if user_response.status_code != 200:
        print(f"Error: Unable to fetch user data for ID {employee_id}")
        sys.exit(1)
    user_data = user_response.json()

    # Fetch TODO data
    todos_response = requests.get(todos_url)
    if todos_response.status_code != 200:
        print(f"Error: Unable to fetch TODO data for ID {employee_id}")
        sys.exit(1)
    todos_data = todos_response.json()

    return user_data, todos_data

def display_todo_progress(employee_name, todos):
    """Display the TODO list progress for the employee."""
    total_tasks = len(todos)
    done_tasks = sum(1 for task in todos if task.get("completed"))

    print(f"Employee {employee_name} is done with tasks({done_tasks}/{total_tasks}):")
    for task in todos:
        if task.get("completed"):
            print(f"\t {task.get('title')}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 0-gather_data_from_an_API.py <employee_id>")
        sys.exit(1)

    employee_id = int(sys.argv[1])
    user_data, todos_data = fetch_employee_data(employee_id)
    display_todo_progress(user_data.get("name"), todos_data)
